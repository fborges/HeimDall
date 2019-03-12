//
//  Date+Extensions.swift
//  HeimDall
//
//  Created by Felipe Borges  on 12/03/19.
//

import Foundation

extension Date {
    func isAheadOf(date: Date) -> Bool {
        return self.compare(date) == .orderedAscending
    }
}
