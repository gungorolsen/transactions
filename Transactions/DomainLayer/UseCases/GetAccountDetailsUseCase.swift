//
//  GetTransactionsUseCase.swift
//  Transactions
//
//  Created by Olsen Gungor on 2/12/2022.
//

protocol GetAccountDetailsUseCase {
    func getAccountDetails() async throws -> AccountDetails
}

class GetAccountDetailsUseCaseImpl {
    
    private let accountDetailsService: AccountDetailsRepo
    
    init(accountDetailsService: AccountDetailsRepo = AccountDetailsService()) {
        self.accountDetailsService = accountDetailsService
    }
}

extension GetAccountDetailsUseCaseImpl: GetAccountDetailsUseCase {
    
    func getAccountDetails() async throws -> AccountDetails {
        try await accountDetailsService.fetchAccountDetails()
    }
}
