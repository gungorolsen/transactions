//
//  AccountDetailsMapper.swift
//  Transactions
//
//  Created by Olsen Gungor on 2/12/2022.
//

import Foundation

protocol AccountDetailsMapping {
    func mapToDomain(from response: AccountDetailsResponse) -> AccountDetails
}

class AccountDetailsMapper: AccountDetailsMapping {

    func mapToDomain(from response: AccountDetailsResponse) -> AccountDetails {
        AccountDetails(
            account: mapAccount(response.account),
            transactions: mapTransactions(response.transactions, type: .confirmed, atms: response.atms) +
                mapTransactions(response.pending, type: .pending, atms: response.atms)
        )
    }
    
    private func mapAccount(_ response: AccountDetailsResponse.Account) -> AccountDetails.Account {
        .init(
            accountName: response.accountName,
            accountNumber: response.accountNumber,
            available: response.available,
            balance: response.balance
        )
    }

    private func mapTransactions(
        _ response: [AccountDetailsResponse.Transaction],
        type: AccountDetails.TransactionType,
        atms: [AccountDetailsResponse.ATM]?
    ) -> [AccountDetails.Transaction] {
        response.compactMap {
            guard let date = dateFormatter.date(from: $0.effectiveDate) else {
                return nil
            }
            
            return .init(id: $0.id,
                         type: type,
                         desc: $0.desc,
                         effectiveDate: date,
                         amount: $0.amount,
                         atm: mapAtm(atms, atmId: $0.atmId)
            )
        }
    }

    private func mapAtm(_ atms: [AccountDetailsResponse.ATM]?, atmId: String?) -> AccountDetails.ATM? {
        guard let atm = atms?.first(where: { $0.id == atmId }) else {
            return nil
        }
        return .init(id: atm.id, name: atm.name, address: atm.address, location: mapLocation(atm.location))
    }
    
    private func mapLocation(_ response: AccountDetailsResponse.Location) -> AccountDetails.Location {
        .init(lat: response.lat, lng: response.lng)
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()
}
