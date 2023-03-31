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
    private var total: Int {wins + losses}
    
    public var winPercentage: Int {wins.percentage(of: total)}
    public var losePercentage: Int {losses.percentage(of: total)}

    public var neverLost:Bool {losses==0}
    public var neverWon:Bool {wins==0}

    public var topLeftText: String {String(describing: wins)}
    public var topRightText: String {String(describing: losses)}
    public var bottomLeftText: String {"\(wins.percentage(of: total))% Won"}
    public var bottomRightText: String {"\(losses.percentage(of: total))% Lost"}
    
    public var showButtomLeftText: Bool {wins != 0}
    public var showButtomRighText: Bool {losses != 0}
    public var showTopLeftText: Bool {wins != 0}
    public var showTopRighText: Bool {losses != 0}

    init(wins: Int, losses: Int) {
        self.wins = wins
        self.losses = losses
    }
    
}
