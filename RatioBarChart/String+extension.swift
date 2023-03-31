//
//  String+extension.swift
//  RatioBarChart
//
//  Created by Keyvan on 3/31/23.
//

import Foundation
import UIKit

extension String {
    func sizeUsingFont(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
}
