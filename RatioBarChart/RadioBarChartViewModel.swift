//
//  RadioBarChartViewModel.swift
//  RatioBarChart
//
//  Created by Keyvan on 3/ł1/23.
//

import Foundation
import UIKit

class RadioBarChartViewModelImp:
    RadioBarChartViewModel,
    RadioBarChartViewModelInputs,
    RadioBarChartViewModelOutputs {
    
    var inputs: RadioBarChartViewModelInputs {self}
    var outputs: RadioBarChartViewModelOutputs {self}
    
    init(wins: Int, losses: Int) {
        self.wins = wins
        self.losses = losses
    }
    
    // MARK: - Outputs:
    
    private let wins:Int
    private let losses:Int
    private var total: Int {wins + losses}
    
    public var winRatio: CGFloat {CGFloat(wins.percentage(of: total))/100}
    public var loseRatio: CGFloat {CGFloat(losses.percentage(of: total))/100}

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

    @Published var topSpacerWidth: CGFloat = 0
    @Published var bottomSpacerWidth: CGFloat = 0
    
    public var topFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    public var bottomFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .medium)

    // MARK: - Intputs:
    func calculateTopSpacerWidth(with parentWidth: CGFloat) {
        let topRightTextWidth = topRightText.sizeUsingFont(usingFont: topFont).width
        var calculation = (parentWidth * loseRatio) - topRightTextWidth
        if (calculation < 0 || pinToRight(parentWidth)) && !neverWon { topSpacerWidth = 0 }
        if neverWon { calculation -= 8 }
        topSpacerWidth = calculation
    }
    func calculateBottomSpacerWidth(with parentWidth: CGFloat) {
        let bottomRightTextWidth = bottomRightText.sizeUsingFont(usingFont: bottomFont).width
        var calculation = (parentWidth * loseRatio) - bottomRightTextWidth
        if (calculation < 0 || pinToRight(parentWidth)) && !neverWon { bottomSpacerWidth = 0 }
        if neverWon { calculation -= 8 }
        bottomSpacerWidth = calculation

    }
    func setTopFont(_ font: UIFont) {self.topFont = font}
    func setBottomFont(_ font: UIFont) {self.bottomFont = font}
    
    private func pinToRight(_ width: CGFloat) -> Bool {
        let bottomLeftTextWidth = bottomLeftText.sizeUsingFont(usingFont: bottomFont).width
        let calculation = (width * loseRatio)
        return width < calculation + bottomLeftTextWidth + 8
    }
}

protocol RadioBarChartViewModelInputs {
    func calculateTopSpacerWidth(with parentWidth: CGFloat)
    func calculateBottomSpacerWidth(with parentWidth: CGFloat)
    func setTopFont(_ font: UIFont)
    func setBottomFont(_ font: UIFont)

}

protocol RadioBarChartViewModelOutputs {
    var winRatio: CGFloat { get }
    var loseRatio: CGFloat { get }

    var neverLost:Bool { get }
    var neverWon:Bool { get }

    var topLeftText: String { get }
    var topRightText: String { get }
    var bottomLeftText: String { get }
    var bottomRightText: String { get }
    
    var showButtomLeftText: Bool { get }
    var showButtomRighText: Bool { get }
    var showTopLeftText: Bool { get }
    var showTopRighText: Bool { get }

    var topSpacerWidth: CGFloat { get }
    var bottomSpacerWidth: CGFloat { get }
    
    var topFont: UIFont { get }
    var bottomFont: UIFont { get }
}

protocol RadioBarChartViewModel:AnyViewModel {
    var inputs:RadioBarChartViewModelInputs { get }
    var outputs: RadioBarChartViewModelOutputs { get }
}
