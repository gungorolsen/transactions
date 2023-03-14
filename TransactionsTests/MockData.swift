//
//  MockData.swift
//  Transactions
//
//  Created by Olsen Gungor on 02/12/2022.
//

import Foundation
@testable import Transactions

struct MocksData {
    static let accountDetailsData = Data(mockResponse.utf8)
    static let accountDetails = try! JSONDecoder().decode(AccountDetailsResponse.self, from: accountDetailsData)


    static let domainAccountDetails = AccountDetails(account: .init(accountName: "name",
                                                                    accountNumber: "num",
                                                                    available: 20,
                                                                    balance: 10),
                                                     transactions: [
                                                        .init(id: "id",
                                                              type: .pending,
                                                              desc: "desc",
                                                              effectiveDate: Date(timeIntervalSince1970: 1670202334),
                                                              amount: 100,
                                                              atm: .init(id: "id",
                                                                         name: "name",
                                                                         address: "add",
                                                                         location: .init(lat: 10, lng: 20)))
                                                     ])


    static let invalidResponse1 = HTTPURLResponse(url: URL(string: "http://localhost:8080")!,
                                                  statusCode: 400,
                                                  httpVersion: nil,
                                                  headerFields: nil)
    
    static let invalidResponse2 = URLResponse(url: URL(string: "http://localhost:8080")!,
                                              mimeType: nil,
                                              expectedContentLength: 0,
                                              textEncodingName: nil)

    static let validResponse = HTTPURLResponse(url: URL(string: "http://localhost:8080")!,
                                               statusCode: 200,
                                               httpVersion: nil,
                                               headerFields: nil)
}

let mockResponse = """
{
    "account" : {
        "accountName": "Complete Access",
        "accountNumber": "062005 1709 5888",
        "available": 226.76,
        "balance": 246.76
    },
    "transactions": [{
        "id": "44e5b2bc484331ea24afd85ecfb212c8",
        "effectiveDate": "20/09/2022",
        "description": "Kaching TFR",
        "amount": 12.00
    }, {
        "id": "1506aeeb8c3a699b1e3c87db03156428",
        "effectiveDate": "20/09/2022",
        "description": "Wdl ATM CBA ATM",
        "amount": -200.00,
        "atmId": "129382"
    }],
    "pending" : [{
        "id": "e2eff6c2dafd909df8508f891b385d88",
        "description": "WILSON PARKING",
        "effectiveDate": "22/08/2022",
        "amount": -12.00
    }],
    "atms": [
        {
            "id": "129382",
            "name": "Circular Quay Station",
            "address": "8 Alfred St, Sydney, NSW 2000",
            "location": {
                "lat": -33.861382,
                "lng": 151.210316
            }
        },
        {
            "id": "137483",
            "name": "Town Hall Square",
            "address": "464-480 Kent St, Sydney, NSW 2000",
            "location": {
                "lat": -33.873181,
                "lng": 151.205389
            }
        }
    ]
}
"""
