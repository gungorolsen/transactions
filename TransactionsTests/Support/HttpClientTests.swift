//
//  HttpClientTests.swift
//  TransactionsTests
//
//  Created by Olsen Gungor on 05/12/2022.
//

import XCTest
@testable import Transactions

class HttpClientTests: XCTestCase {

    var mockUrlSessionProvider: MockURLSessionProvider!
    var client: HTTPClient!
    
    override func setUpWithError() throws {
        mockUrlSessionProvider = MockURLSessionProvider()
        client = HTTPClient(urlSessionProvider: mockUrlSessionProvider)
    }

    override func tearDownWithError() throws {
        mockUrlSessionProvider = nil
        client = nil
    }

    func testSuccessfulCall() async throws {
        mockUrlSessionProvider.response = MocksData.validResponse
        mockUrlSessionProvider.returnedData = MocksData.accountDetailsData
        
        do {
            let accountDetails: AccountDetailsResponse = try await client.dataTaskPublisher(urlString: "http://google.com")
            XCTAssertNotNil(accountDetails)
            XCTAssertTrue(mockUrlSessionProvider.isDataReturned)
        } catch {
            XCTFail()
        }
    }

    func testMalformedUrlCall() async throws {
        mockUrlSessionProvider.response = MocksData.validResponse
        mockUrlSessionProvider.returnedData = "{}".data(using: .utf8)
        
        do {
            let _: AccountDetailsResponse = try await client.dataTaskPublisher(urlString: "http :// google.com")
            XCTFail()
        } catch {
            XCTAssertEqual(error as? HttpError, .invalidURL(url: "http :// google.com"))
        }
    }

    
    func testHttpErrprCall() async throws {
        mockUrlSessionProvider.response = MocksData.invalidResponse1
        mockUrlSessionProvider.returnedData = "{}".data(using: .utf8)
        
        do {
            let _: AccountDetailsResponse = try await client.dataTaskPublisher(urlString: "http://google.com")
            XCTFail()
        } catch {
            XCTAssertEqual(error as? HttpError, .failure(code: 400))
        }
    }

    func testInvalidResponseCall() async throws {
        mockUrlSessionProvider.response = MocksData.invalidResponse2
        mockUrlSessionProvider.returnedData = "{}".data(using: .utf8)
        
        do {
            let _: AccountDetailsResponse = try await client.dataTaskPublisher(urlString: "http://google.com")
            XCTFail()
        } catch {
            XCTAssertEqual(error as? HttpError, .invalidResponse)
        }
    }
}

class MockURLSessionProvider: URLSessionProviding {
    
    var returnedData: Data?
    var response: URLResponse?
    var error: Error?
    
    private(set) var isDataReturned = false
    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }
        
        guard let returnedData = returnedData, let response = response else {
            throw HttpError.invalidResponse
        }

        isDataReturned = true
        return (returnedData, response)
    }
}

extension HttpError: Equatable {
    public static func == (lhs: HttpError, rhs: HttpError) -> Bool {
        switch(lhs, rhs) {
        case(.invalidResponse, .invalidResponse): return true
        case(.failure(let lhsCode), .failure(let rhsCode)): return lhsCode == rhsCode
        case(.invalidURL(let lhsUrl), .invalidURL(let rhsUrl)): return lhsUrl == rhsUrl
        default: return false
        }
    }
}
