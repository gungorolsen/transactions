//
//  AccountDetailsViewModel.swift
//  Transactions
//
//  Created by Olsen Gungor on 3/12/2022.
//

import Foundation
import MapKit

struct AccountDetailsViewItem {
    
    let accountName: String
    let accountNumber: String
    let availableBalance: String
    let availableFunds: String

    let groupedTransactions: [TransactionGroupSectionViewItem: [TransactionViewItem]]

    var sortedGroupedTransactions: [TransactionGroupSectionViewItem] {
        groupedTransactions.keys.sorted(by: >)
    }
    
    func getTransactions(for key: TransactionGroupSectionViewItem) -> [TransactionViewItem] {
         groupedTransactions[key] ?? []
    }
}

struct TransactionViewItem: Identifiable {
    let id: String
    let description: String
    let pendingDescription: String
    let amount: String
    let atm: AtmMapViewItem?

    var isAtm: Bool { atm != nil }
}

struct TransactionGroupSectionViewItem: Hashable, Comparable {
    
    private let date: Date
    private let dateFormatter: DateFormatter

    init(date: Date, dateFormatter: DateFormatter) {
        self.date = date
        self.dateFormatter = dateFormatter
    }

    var displayDate: String {
        dateFormatter.string(from: date)
    }

    // today? yesterday?
    var sinceDisplayDate: String {
        String(format: "%i Days Ago", Calendar.current.numberOfDaysBetween(date, and: Date()) ?? 0)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
    }
    
    static func < (lhs: TransactionGroupSectionViewItem, rhs: TransactionGroupSectionViewItem) -> Bool {
        lhs.date < rhs.date
    }
}

struct AtmMapViewItem: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
