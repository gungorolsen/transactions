//
//  AccountDetailsViewModelTests.swift
//  TransactionsTests
//
//  Created by Oguzhan Gungor on 5/12/2022.
//

import XCTest
@testable import Transactions

class AccountDetailsViewModelTests: XCTestCase {
    
    private var viewModel: AccountDetailsViewModel!
    private var useCase: GetAccountDetailsUseCaseMockingSpy!
    private var transformer: AccountDetailsViewItemTransfomerSpy!

    @MainActor
    override func setUpWithError() throws {
        useCase = GetAccountDetailsUseCaseMockingSpy()
        transformer = AccountDetailsViewItemTransfomerSpy()
        viewModel = AccountDetailsViewModel(getTransactionsUseCase: useCase, transformer: transformer)
    }

    override func tearDownWithError() throws {
        useCase = nil
        transformer = nil
        viewModel = nil
    }
    
    @MainActor
    func testInitialState() async throws {
        XCTAssertEqual(viewModel.state, .loading)
    }

    @MainActor
    func testRefreshList() async throws {
        await viewModel.refreshAccountDetails()
        XCTAssertTrue(useCase.isGetAccountDetailsCalled)
    }

    @MainActor
    func testGetAccountDetails() async throws {
        useCase.returnedAccount = MocksData.domainAccountDetails
        await viewModel.refreshAccountDetails()
        
        if case .loaded = viewModel.state {
        } else {
            XCTFail()
        }
    }

    @MainActor
    func testGetAccountDetailsFailure() async throws {
        await viewModel.refreshAccountDetails()
        XCTAssertEqual(viewModel.state, .error)
    }
}

class GetAccountDetailsUseCaseMockingSpy: GetAccountDetailsUseCase {
    var returnedAccount: AccountDetails?
    private(set) var isGetAccountDetailsCalled = false
    func getAccountDetails() async throws -> AccountDetails {
        isGetAccountDetailsCalled = true
        if let returnedAccount = returnedAccount {
            return returnedAccount
        }
        throw NSError()
    }
}

class AccountDetailsViewItemTransfomerSpy: AccountDetailsViewItemTransforming {
    
    private(set) var isMapToViewItemCalled = false
    func mapToViewItem(_ accountDetails: AccountDetails) -> AccountDetailsViewItem {
        isMapToViewItemCalled = true
        return .init(accountName: "", accountNumber: "", availableBalance: "", availableFunds: "", groupedTransactions: [:])
    }
}

extension ViewState: Equatable {
    public static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        switch(lhs, rhs) {
        case(.loading, .loading): return true
        case(.error, .error): return true
        case(.loaded(let lhsAccount), .loaded(let rhsAccount)): return lhsAccount.accountNumber == rhsAccount.accountNumber
        default: return false
        }
    }
}
