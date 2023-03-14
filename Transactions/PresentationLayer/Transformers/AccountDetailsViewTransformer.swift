//
//  AccountDetailsViewTransformer.swift
//  Transactions
//
//  Created by Olsen Gungor on 4/12/2022.
//

import Foundation

protocol AccountDetailsViewItemTransforming {
    
    func mapToViewItem(_ accountDetails: AccountDetails) -> AccountDetailsViewItem
}

final class AccountDetailsViewItemTransformer: AccountDetailsViewItemTransforming {
    
    private lazy var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "AUD"
        formatter.currencySymbol = "$"
        return formatter
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter
    }()

    
    func mapToViewItem(_ accountDetails: AccountDetails) -> AccountDetailsViewItem {
        AccountDetailsViewItem(
            accountName: accountDetails.account.accountName,
            accountNumber: accountDetails.account.accountNumber,
            availableBalance: currencyFormatter.string(from: accountDetails.account.balance.toNumber()) ?? "N/A",
            availableFunds: currencyFormatter.string(from: accountDetails.account.available.toNumber()) ?? "N/A",
            groupedTransactions: mapGroupedTransactions(accountDetails.transactions)
        )
    }

}

private extension AccountDetailsViewItemTransformer {
    
    func mapGroupedTransactions(
        _ transactions: [AccountDetails.Transaction]
    ) -> [TransactionGroupSectionViewItem: [TransactionViewItem]] {
        transactions.reduce(into: [:]) { section, transaction in
            let existing = section[TransactionGroupSectionViewItem(date: transaction.effectiveDate, dateFormatter: dateFormatter)] ?? []
            section[TransactionGroupSectionViewItem(date: transaction.effectiveDate, dateFormatter: dateFormatter)] = existing + [mapTransaction(transaction)]
        }
    }
    
    func mapTransaction(_ transaction: AccountDetails.Transaction) -> TransactionViewItem {
        TransactionViewItem(
            id: transaction.id,
            description: transaction.desc.replacingOccurrences(of: "<br/>", with: "\n"),
            pendingDescription: transaction.type == .pending ? "PENDING: " : "",
            amount: currencyFormatter.string(from: transaction.amount.toNumber()) ?? "N/A",
            atm: mapAtm(transaction.atm)
        )
    }
    
    private func mapAtm(_ atm: AccountDetails.ATM?) -> AtmMapViewItem? {
        guard let atm = atm else { return nil }
        return AtmMapViewItem(name: atm.name,
                              coordinate: .init(latitude: atm.location.lat, longitude: atm.location.lng))
    }
}
