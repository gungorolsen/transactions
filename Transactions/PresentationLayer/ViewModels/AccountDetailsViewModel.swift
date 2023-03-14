//
//  TransactionListViewModel.swift
//  Transactions
//
//  Created by Olsen Gungor on 3/12/2022.
//

import Foundation

enum ViewState {
    case loading
    case loaded(AccountDetailsViewItem)
    case error
}

final class AccountDetailsViewModel: ObservableObject {

    @Published
    @MainActor
    var state: ViewState = .loading

    private let getAccountDetailsUseCase: GetAccountDetailsUseCase
    private let transformer: AccountDetailsViewItemTransforming

    init(getTransactionsUseCase: GetAccountDetailsUseCase = GetAccountDetailsUseCaseImpl(),
         transformer: AccountDetailsViewItemTransforming = AccountDetailsViewItemTransformer()) {
        self.getAccountDetailsUseCase = getTransactionsUseCase
        self.transformer = transformer
    }
}

extension AccountDetailsViewModel {

    func refreshAccountDetails() async {
        do {
            let accountDetails = try await getAccountDetailsUseCase.getAccountDetails()
            await setState(.loaded(transformer.mapToViewItem(accountDetails)))
        } catch  {
            await setState(.error)
        }
    }
}


private extension AccountDetailsViewModel {

    @MainActor
    func setState(_ newState: ViewState) {
        state = newState
    }
}
