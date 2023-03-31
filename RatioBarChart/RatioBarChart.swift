//
//  RatioBarChart.swift
//  MyTradingJournal
//
//  Created by James Sedlacek on 11/19/22.
//

import SwiftUI

struct RatioBarChart: View {
    
    @StateObject var vm: RadioBarChartViewModel
    
    let topFont: UIFont
    let bottomFont: UIFont

    init(
        vm: RadioBarChartViewModel,
        topFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .semibold),
        bottomFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .medium)
    ) {
        _vm = StateObject(wrappedValue: vm)
        self.topFont = topFont
        self.bottomFont = bottomFont
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
                            .frame(width: getTopSpacerWidth(geoReader.size.width - 16))
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
                            .frame(width: getBottomSpacerWidth(geoReader.size.width - 16))
                    }
                    .font(
                        .system(
                            size: 14,
                            weight: .medium)
                    )
                    /// -------------------------------------
                }.padding(.horizontal, 8)
            }
        }.frame(height: 60)
    }
    
    private func getTopSpacerWidth(_ width: CGFloat) -> CGFloat {
        let topRightTextWidth = vm.topRightText.sizeUsingFont(usingFont: topFont).width
        var calculation = (width * vm.loseRatio) - topRightTextWidth
        if (calculation < 0 || pinToRight(width)) && !vm.neverWon { return 0 }
        if vm.neverWon { calculation -= 8 }
        return calculation
    }
    
    private func getBottomSpacerWidth(_ width: CGFloat) -> CGFloat {
        let bottomRightTextWidth = vm.bottomRightText.sizeUsingFont(usingFont: bottomFont).width
        var calculation = (width * vm.loseRatio) - bottomRightTextWidth
        if (calculation < 0 || pinToRight(width)) && !vm.neverWon { return 0 }
        if vm.neverWon { calculation -= 8 }
        return calculation
    }
    
    private func pinToRight(_ width: CGFloat) -> Bool {
        let bottomLeftTextWidth = vm.bottomLeftText.sizeUsingFont(usingFont: bottomFont).width
        let calculation = (width * vm.loseRatio)
        return width < calculation + bottomLeftTextWidth + 8
    }
    
    private func greenRedLine(_ width: CGFloat) -> some View {
        return HStack(spacing: 0) {
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

struct RatioBarChart_Previews: PreviewProvider {
    static var previews: some View {
        RatioBarChart(vm: RadioBarChartViewModel(wins: 4, losses: 10))
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension String {
   func sizeUsingFont(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
}

//struct GreenRedLine: View {
//    let width: CGFloat
//    @ObservedObject var vm: RadioBarChartViewModel
//
//    init(_ width: CGFloat,
//         vm: RadioBarChartViewModel
//    ) {
//        self.width = width
//        self.vm = vm
//    }
//    var body: some View {
//
//        HStack(spacing: 0) {
//            Rectangle()
//                .frame(height: 12)
//                .foregroundColor(.green)
//                .cornerRadius(
//                    6,
//                    corners: vm.neverLost ? .allCorners : [.topLeft, .bottomLeft])
//                .frame(width: width * CGFloat(vm.winRatio))
//            Rectangle()
//                .frame(height: 12)
//                .foregroundColor(.red)
//                .cornerRadius(
//                    6,
//                    corners: vm.neverWon ? .allCorners : [.topRight, .bottomRight])
//                .frame(width: width * CGFloat(vm.loseRatio))
//        }
//    }
//}
