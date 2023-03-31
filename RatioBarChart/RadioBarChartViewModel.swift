//
//  RadioBarChartViewModel.swift
//  RatioBarChart
//
//  Created by Keyvan on 3/ł1/23.
//

import Foundation

class RadioBarChartViewModel: ObservableObject {
    let wins:Int
    let losses:Int
    
    init(wins: Int, losses: Int) {
        self.wins = wins
        self.losses = losses
    }
    
}
