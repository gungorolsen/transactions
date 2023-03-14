//
//  TransactionsResponse.swift
//  Transactions
//
//  Created by Olsen Gungor on 2/12/2022.
//

struct AccountDetailsResponse: Decodable {
    let account: Account
    let transactions: [Transaction]
    let pending: [Transaction]
    let atms: [ATM]?
    
    struct Account: Decodable {
        let accountName: String
        let accountNumber: String
        let available: Double
        let balance: Double
    }

    struct ATM: Decodable {
        let id: String
        let name: String
        let address: String
        let location: Location
    }

    struct Location: Decodable {
        let lat: Double
        let lng: Double
    }

    struct Transaction: Decodable {
        let id: String
        let desc: String
        let effectiveDate: String
        let amount: Double
        let atmId: String?

        enum CodingKeys: String, CodingKey {
            case id, effectiveDate, amount, atmId
            case desc = "description"
        }
    }
}
