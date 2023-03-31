//
//  ContentView.swift
//  RatioBarChart
//
//  Created by James Sedlacek on 3/30/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            RatioBarChart(vm: RadioBarChartViewModelImp(wins: 10, losses: 10))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
