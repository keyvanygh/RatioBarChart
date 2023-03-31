//
//  RadioBarChartViewModel.swift
//  RatioBarChart
//
//  Created by Keyvan on 3/ł1/23.
//

import Foundation

class RadioBarChartViewModel: ObservableObject {
    private let wins:Int
    private let losses:Int
    private var total: Int {
        return wins + losses
    }
    
    public var bottomLeftText: String {
        return "\(wins.percentage(of: total)) + % Won"
    }
    public var bottomRightText: String {
        return "\(losses.percentage(of: total)) + % Lost"
    }

    init(wins: Int, losses: Int) {
        self.wins = wins
        self.losses = losses
    }
    
}
