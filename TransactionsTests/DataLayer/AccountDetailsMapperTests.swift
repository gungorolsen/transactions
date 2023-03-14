//
//  AccountDetailsMapperTests.swift
//  TransactionsTests
//
//  Created by Oguzhan Gungor on 5/12/2022.
//

import XCTest
@testable import Transactions

class AccountDetailsMapperTests: XCTestCase {

    var mapper: AccountDetailsMapping!
    
    override func setUpWithError() throws {
        mapper = AccountDetailsMapper()
    }

    override func tearDownWithError() throws {
        mapper = nil
    }

    func testMapper() {
        let accountDetails = mapper.mapToDomain(from: MocksData.accountDetails)
        XCTAssertEqual(accountDetails.account.accountNumber, "062005 1709 5888")
        XCTAssertEqual(accountDetails.account.accountName, "Complete Access")
        XCTAssertEqual(accountDetails.account.balance, 246.76)
        XCTAssertEqual(accountDetails.account.available, 226.76)

        XCTAssertEqual(accountDetails.transactions.count, 3)

        XCTAssertEqual(accountDetails.transactions[0].desc, "Kaching TFR")
        XCTAssertEqual(accountDetails.transactions[0].amount, 12)
        XCTAssertEqual(accountDetails.transactions[0].type, .confirmed)
        XCTAssertNil(accountDetails.transactions[0].atm)

        XCTAssertEqual(accountDetails.transactions[1].desc, "Wdl ATM CBA ATM")
        XCTAssertEqual(accountDetails.transactions[1].amount, -200)
        XCTAssertEqual(accountDetails.transactions[1].type, .confirmed)
        XCTAssertEqual(accountDetails.transactions[1].atm?.name, "Circular Quay Station")

        
        XCTAssertEqual(accountDetails.transactions[2].desc, "WILSON PARKING")
        XCTAssertEqual(accountDetails.transactions[0].amount, 12)
        XCTAssertEqual(accountDetails.transactions[2].type, .pending)
        XCTAssertNil(accountDetails.transactions[2].atm)
    }
}
