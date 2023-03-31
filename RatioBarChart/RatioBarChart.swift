//
//  RatioBarChart.swift
//  MyTradingJournal
//
//  Created by James Sedlacek on 11/19/22.
//

import SwiftUI

struct RatioBarChart<ViewModel>: View where ViewModel: RadioBarChartViewModel {
    
    @StateObject var vm: ViewModel
    
    init(
        vm: ViewModel,
        topFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .semibold),
        bottomFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .medium)
    ) {
        self._vm = StateObject(wrappedValue: vm)
        self.vm.inputs.setTopFont(topFont)
        self.vm.inputs.setBottomFont(bottomFont)
    }
    
    var body: some View {
        Section {
            GeometryReader { geoReader in
                VStack {
                    // MARK: Top Section
                    /// -------------------------------------
                    HStack {
                        if vm.outputs.showTopLeftText {
                            /// Top Left Text
                            Text(vm.outputs.topLeftText)
                                .foregroundColor(.green)
                        }
                        Spacer()
                        if vm.outputs.showTopRighText {
                            /// Top Right Text
                            Text(vm.outputs.topRightText)
                                .foregroundColor(.red)
                                .fixedSize()
                        }
                        Spacer()
                            .frame(width: vm.outputs.topSpacerWidth)
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
                    GreenRedLine(
                        geoReader.size.width - 16,
                        vm: vm)
                    /// -------------------------------------
                    // MARK: Buttom Section
                    /// -------------------------------------
                    HStack {
                        if vm.outputs.showButtomLeftText {
                            /// Bottom Left Text
                            Text(vm.outputs.bottomLeftText)
                                .foregroundColor(.green)
                        }
                        Spacer()
                        if vm.outputs.showButtomRighText {
                            /// Bottom Right Text
                            Text(vm.outputs.bottomRightText)
                                .foregroundColor(.red)
                                .fixedSize()
                        }
                        Spacer()
                            .frame(width: vm.outputs.bottomSpacerWidth)
                    }
                    .font(
                        .system(
                            size: 14,
                            weight: .medium)
                    )
                    /// -------------------------------------
                }.padding(.horizontal, 8)
                    .onAppear {
                        vm.inputs.calculateTopSpacerWidth(with: geoReader.size.width - 16)
                        vm.inputs.calculateBottomSpacerWidth(with: geoReader.size.width - 16)
                    }
            }
        }.frame(height: 60)
    }
    

}

struct RatioBarChart_Previews: PreviewProvider {
    static var previews: some View {
        RatioBarChart(vm: RadioBarChartViewModelImp(wins: 10, losses: 10))
    }
}

struct GreenRedLine<ViewModel>: View where ViewModel: RadioBarChartViewModel {
    let width: CGFloat
    @ObservedObject var vm: ViewModel

    init(_ width: CGFloat,
         vm: ViewModel
    ) {
        self.width = width
        self._vm = ObservedObject(wrappedValue: vm)
    }
    var body: some View {

        HStack(spacing: 0) {
            Rectangle()
                .frame(height: 12)
                .foregroundColor(.green)
                .cornerRadius(
                    6,
                    corners: vm.outputs.neverLost ? .allCorners : [.topLeft, .bottomLeft])
                .frame(width: width * CGFloat(vm.outputs.winRatio))
            Rectangle()
                .frame(height: 12)
                .foregroundColor(.red)
                .cornerRadius(
                    6,
                    corners: vm.outputs.neverWon ? .allCorners : [.topRight, .bottomRight])
                .frame(width: width * CGFloat(vm.outputs.loseRatio))
        }
    }
}
