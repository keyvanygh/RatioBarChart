//
//  Int+extension.swift
//  RatioBarChart
//
//  Created by Keyvan on 3/31/23.
//

import Foundation

extension Int {
    
    /// calculate and returns percentage of the number from a given total
    /// - Parameters:
    ///   - total : e.g: 5 is 50% of total so total is 10
    /// - Returns:
    ///   - calculated percentage
    func percentage(of total: Int) -> Int {
        if total == 0 { return 0 }
        return Int(Double(self) / Double(total) * 100)
    }
}
