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
    
    public var topLeftText: String {
        return String(describing: wins)
    }
    public var topRightText: String {
        return String(describing: losses)
    }
    public var showTopLeftText: Bool {
        return wins != 0
    }
    public var showTopRighText: Bool {
        return losses != 0
    }
    public var bottomLeftText: String {
        return "\(wins.percentage(of: total))% Won"
    }
    public var bottomRightText: String {
        return "\(losses.percentage(of: total))% Lost"
    }
    public var showButtomLeftText: Bool {
        return wins != 0
    }
    public var showButtomRighText: Bool {
        return losses != 0
    }

    init(wins: Int, losses: Int) {
        self.wins = wins
        self.losses = losses
    }
    
}
