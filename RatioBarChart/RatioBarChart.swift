//
//  RatioBarChart.swift
//  MyTradingJournal
//
//  Created by James Sedlacek on 11/19/22.
//

import SwiftUI

struct RatioBarChart: View {
    
    @StateObject var vm: RadioBarChartViewModel
    
    init(
        vm: RadioBarChartViewModel,
        topFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .semibold),
        bottomFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .medium)
    ) {
        vm.topFont = topFont
        vm.bottomFont = bottomFont
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        Section {
            GeometryReader { geoReader in
                VStack {
                    // MARK: Top Section
                    /// -------------------------------------
                    HStack {
                        if vm.showTopLeftText {
                            /// Top Left Text
                            Text(vm.topLeftText)
                                .foregroundColor(.green)
                        }
                        Spacer()
                        if vm.showTopRighText {
                            /// Top Right Text
                            Text(vm.topRightText)
                                .foregroundColor(.red)
                                .fixedSize()
                        }
                        Spacer()
                            .frame(width: vm.topSpacerWidth)
                    }
                    .padding(.bottom, -2)
                    .font(
                        .system(
                            size: 16,
                            weight: .semibold)
                    )
                    /// -------------------------------------
                    // MARK: Middle Section
                    /// -------------------------------------
                    greenRedLine(geoReader.size.width - 16)
                    /// -------------------------------------
                    // MARK: Buttom Section
                    /// -------------------------------------
                    HStack {
                        if vm.showButtomLeftText {
                            /// Bottom Left Text
                            Text(vm.bottomLeftText)
                                .foregroundColor(.green)
                        }
                        Spacer()
                        if vm.showButtomRighText {
                            /// Bottom Right Text
                            Text(vm.bottomRightText)
                                .foregroundColor(.red)
                                .fixedSize()
                        }
                        Spacer()
                            .frame(width: vm.bottomSpacerWidth)
                    }
                    .font(
                        .system(
                            size: 14,
                            weight: .medium)
                    )
                    /// -------------------------------------
                }.padding(.horizontal, 8)
                    .onAppear {
                        vm.calculateTopSpacerWidth(with: geoReader.size.width - 16)
                        vm.calculateBottomSpacerWidth(with: geoReader.size.width - 16)
                    }
            }
        }.frame(height: 60)
    }
    
    struct GreenRedLine: View {
        let width: CGFloat
        @ObservedObject var vm: RadioBarChartViewModel

        init(_ width: CGFloat,
             vm: RadioBarChartViewModel
        ) {
            self.width = width
            self.vm = vm
        }
        var body: some View {

            HStack(spacing: 0) {
                Rectangle()
                    .frame(height: 12)
                    .foregroundColor(.green)
                    .cornerRadius(
                        6,
                        corners: vm.neverLost ? .allCorners : [.topLeft, .bottomLeft])
                    .frame(width: width * CGFloat(vm.winRatio))
                Rectangle()
                    .frame(height: 12)
                    .foregroundColor(.red)
                    .cornerRadius(
                        6,
                        corners: vm.neverWon ? .allCorners : [.topRight, .bottomRight])
                    .frame(width: width * CGFloat(vm.loseRatio))
            }
        }
    }
}

struct RatioBarChart_Previews: PreviewProvider {
    static var previews: some View {
        RatioBarChart(vm: RadioBarChartViewModel(wins: 4, losses: 10))
    }
}

