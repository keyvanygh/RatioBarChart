//
//  RatioBarChart.swift
//  MyTradingJournal
//
//  Created by James Sedlacek on 11/19/22.
//

import SwiftUI

struct RatioBarChart: View {
    
    @StateObject var vm: RadioBarChartViewModel
    
//    let topFont: UIFont
//    let bottomFont: UIFont
//    let bottomLeftText: String
//    let bottomRightText: String
//
    init(
        vm: RadioBarChartViewModel,
        topFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .semibold),
        bottomFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .medium)
    ) {
        _vm = StateObject(wrappedValue: vm)
//        self.topFont = topFont
//        self.bottomFont = bottomFont
//        self.bottomLeftText = "\(HelperFunctions.getPercentage(for: wins, total: wins + losses))% Won"
//        self.bottomRightText = "\(100 - HelperFunctions.getPercentage(for: wins, total: wins + losses))% Lost"
    }
    
    var body: some View {
        Section {
            GeometryReader { geoReader in
                VStack {
                    HStack {
                        if vm.showTopLeftText {
                            Text(vm.topLeftText)
                                .foregroundColor(.green)
                        }
                        Spacer()
                        if vm.showTopRighText {
                            Text(vm.topRightText)
                                .foregroundColor(.red)
                                .fixedSize()
                        }
//                        Spacer().frame(width: getTopSpacerWidth(geoReader.size.width - 16))
                    }.padding(.bottom, -2).font(.system(size: 16, weight: .semibold))
//                    greenRedLine(geoReader.size.width - 16)
                    HStack {
                        if vm.showButtomLeftText {
                            Text(vm.bottomLeftText).foregroundColor(.green)
                        }
                        Spacer()
                        if vm.showButtomRighText {
                            Text(vm.bottomRightText).foregroundColor(.red).fixedSize()
                        }
//                        Spacer().frame(width: getBottomSpacerWidth(geoReader.size.width - 16))
                    }.font(.system(size: 14, weight: .medium))
                }.padding(.horizontal, 8)
            }
        }.frame(height: 60)
    }
    
//    private func getTopSpacerWidth(_ width: CGFloat) -> CGFloat {
//        let topRightTextWidth = "\(losses)".sizeUsingFont(usingFont: topFont).width
//        var calculation = (width * CGFloat(getPercentage(for: losses, total: wins + losses)) / 100) - topRightTextWidth
//        if (calculation < 0 || pinToRight(width)) && wins != 0 { return 0 }
//        if wins == 0 { calculation -= 8 }
//        return calculation
//    }
    
//    private func getBottomSpacerWidth(_ width: CGFloat) -> CGFloat {
//        let bottomRightTextWidth = bottomRightText.sizeUsingFont(usingFont: bottomFont).width
//        var calculation = (width * CGFloat(getPercentage(for: losses, total: wins + losses)) / 100) - bottomRightTextWidth
//        if (calculation < 0 || pinToRight(width)) && wins != 0 { return 0 }
//        if wins == 0 { calculation -= 8 }
//        return calculation
//    }
    
//    private func pinToRight(_ width: CGFloat) -> Bool {
//        let bottomLeftTextWidth = bottomLeftText.sizeUsingFont(usingFont: bottomFont).width
//        let calculation = (width * CGFloat(getPercentage(for: losses, total: wins + losses)) / 100)
//        return width < calculation + bottomLeftTextWidth + 8
//    }
    
//    private func greenRedLine(_ width: CGFloat) -> some View {
//        return HStack(spacing: 0) {
//            Rectangle()
//                .frame(height: 12)
//                .foregroundColor(.green)
//                .cornerRadius(6, corners: losses == 0 ? .allCorners : [.topLeft, .bottomLeft])
//                .frame(width: width * CGFloat(getPercentage(for: wins, total: wins + losses)) / 100)
//            Rectangle()
//                .frame(height: 12)
//                .foregroundColor(.red)
//                .cornerRadius(6, corners: wins == 0 ? .allCorners : [.topRight, .bottomRight])
//                .frame(width: width * CGFloat(100 - getPercentage(for: wins, total: wins + losses)) / 100)
//        }
//    }
}

struct RatioBarChart_Previews: PreviewProvider {
    static var previews: some View {
        RatioBarChart(vm: RadioBarChartViewModel(wins: 10, losses: 10))
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
