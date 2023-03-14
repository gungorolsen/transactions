//
//  AccountDetailsServiceTests.swift
//  TransactionsTests
//
//  Created by Oguzhan Gungor on 5/12/2022.
//

import XCTest
@testable import Transactions

class AccountDetailsServiceTests: XCTestCase {

    private var service: AccountDetailsRepo!
    private var mockHttpClient: MockHttpClient!

    override func setUpWithError() throws {
        mockHttpClient = MockHttpClient()
        service = AccountDetailsService(httpClient: mockHttpClient)
    }

    override func tearDownWithError() throws {
        mockHttpClient = nil
        service = nil
    }

    func testSuccessfulCall() async throws {
        mockHttpClient.returnedResponse = MocksData.accountDetails
        let accountDetails = try await service.fetchAccountDetails()
        XCTAssertNotNil(accountDetails)
    }

    func testUnsuccessfulCall() async throws {
        do {
            let _ = try await service.fetchAccountDetails()
            XCTFail()
        } catch {
            XCTAssertEqual(error as? HttpError, .invalidResponse)
        }
    }
}

class MockHttpClient: HTTPClientType {

    var returnedResponse: Decodable?
    func dataTaskPublisher<T: Decodable>(urlString: String) async throws -> T {
        if let returnedResponse = returnedResponse as? T {
            return returnedResponse
        }
        throw HttpError.invalidResponse
    }
}
