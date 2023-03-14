//
//  CalendarExtensions.swift
//  Transactions
//
//  Created by Oguzhan Gungor on 5/12/2022.
//

import Foundation

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int? {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
        return numberOfDays.day
    }
}
