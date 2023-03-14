//
//  Transactions.swift
//  Transactions
//
//  Created by Olsen Gungor on 2/12/2022.
//

import Foundation

struct AccountDetails {
    let account: Account
    let transactions: [Transaction]
    
    struct Transaction {
        let id: String
        let type: TransactionType
        let desc: String
        let effectiveDate: Date
        let amount: Double
        let atm: ATM?
    }

    struct Account {
        let accountName: String
        let accountNumber: String
        let available: Double
        let balance: Double
    }

    enum TransactionType {
        case confirmed, pending
    }
    
    struct ATM {
        let id: String
        let name: String
        let address: String
        let location: Location
    }

    struct Location {
        let lat: Double
        let lng: Double
    }
}
