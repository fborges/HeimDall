//
//  Rate.swift
//  HeimDall
//
//  Created by Felipe Borges  on 12/03/19.
//

import Foundation

enum TimeUnit {
    case seconds, minutes, hours, days
}

public struct Rate {
    let rate: Int
    let timeUnit: TimeUnit
    let timeMagnitude: Int
    
    internal func dateComponents() -> DateComponents {
        var dateComponents = DateComponents()
        
        switch timeUnit {
        case .seconds:
            dateComponents.second = timeMagnitude
        case .minutes:
            dateComponents.minute = timeMagnitude
        case .hours:
            dateComponents.hour = timeMagnitude
        case .days:
            dateComponents.day = timeMagnitude
        }
        
        return dateComponents
    }
}
