//
//  TransactionsRepo.swift
//  Transactions
//
//  Created by Olsen Gungor on 2/12/2022.
//

import Foundation

protocol AccountDetailsRepo {
    func fetchAccountDetails() async throws -> AccountDetails
}
