//
//  GetAccountDetailsUseCaseTests.swift
//  TransactionsTests
//
//  Created by Oguzhan Gungor on 5/12/2022.
//

import XCTest
@testable import Transactions

class GetAccountDetailsUseCaseTests: XCTestCase {

    private var useCase: GetAccountDetailsUseCase!
    private var service: AccountDetailsServiceMockingSpy!

    override func setUpWithError() throws {
        service = AccountDetailsServiceMockingSpy()
        useCase = GetAccountDetailsUseCaseImpl(accountDetailsService: service)
    }

    override func tearDownWithError() throws {
        service = nil
        useCase = nil
    }

    func testHappyPath() async throws {
        service.returnedDetails = MocksData.domainAccountDetails
        let accountDetails = try await useCase.getAccountDetails()
        XCTAssertNotNil(accountDetails)
    }
    
    func testUnhappyPath() async throws {
        do {
            _ = try await useCase.getAccountDetails()
            XCTFail()
        } catch {}
    }
}

class AccountDetailsServiceMockingSpy: AccountDetailsRepo {
    var returnedDetails: AccountDetails?
    func fetchAccountDetails() async throws -> AccountDetails {
        if let returnedDetails = returnedDetails {
            return returnedDetails
        }
        throw NSError()
    }
}
