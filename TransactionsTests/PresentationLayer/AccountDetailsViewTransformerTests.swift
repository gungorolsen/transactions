//
//  AccountDetailsViewTransformerTests.swift
//  TransactionsTests
//
//  Created by Oguzhan Gungor on 5/12/2022.
//

import XCTest
@testable import Transactions

class AccountDetailsViewTransformerTests: XCTestCase {
    
    private var mapper: AccountDetailsViewItemTransforming!

    override func setUpWithError() throws {
        mapper = AccountDetailsViewItemTransformer()
    }

    override func tearDownWithError() throws {
        mapper = nil
    }
    
    func testMap() throws {
        let viewItem = mapper.mapToViewItem(MocksData.domainAccountDetails)
        XCTAssertEqual(viewItem.accountName, "name")
        XCTAssertEqual(viewItem.accountNumber, "num")
        XCTAssertEqual(viewItem.availableFunds, "$20.00")
        XCTAssertEqual(viewItem.availableBalance, "$10.00")
        
        XCTAssertEqual(viewItem.sortedGroupedTransactions.first?.displayDate, "05 Dec 2022")
        let transactions = viewItem.getTransactions(for: viewItem.sortedGroupedTransactions.first!)
        XCTAssertEqual(transactions.first?.id, "id")
        XCTAssertEqual(transactions.first?.description, "desc")
        XCTAssertEqual(transactions.first?.pendingDescription, "PENDING: ")
        XCTAssertEqual(transactions.first?.amount, "$100.00")
        XCTAssertEqual(transactions.first?.atm?.name, "name")
        XCTAssertEqual(transactions.first?.atm?.coordinate.latitude, 10)
        XCTAssertEqual(transactions.first?.atm?.coordinate.longitude, 20)
    }
}
