//
//  UIFont.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 11.04.2024.
//

import UIKit

extension UIFont {
    enum FontRobotoFlex: String {
        case _900 = "RobotoFlexNormalNormalNormalNormalNormalNormalNormalNormalNormalDefault-ExtraBold"
        case _700 = "RobotoFlexNormalNormalNormalNormalNormalNormalNormalNormalNormalDefault-SemiBold"
        case _500 = "RobotoFlex-Regular"
        case _400 = "RobotoFlexNormalNormalNormalNormalNormalNormalNormalNormalNormalDefault-Medium"
        case _300 = "Roboto-Light"
    }
    class func RobotoFlex(ofSize fonsize: CGFloat,
                    weight: FontRobotoFlex) -> UIFont {
        let customFont = UIFont(name: weight.rawValue,
                                size: fonsize) ?? .systemFont(ofSize: fonsize)
        return UIFontMetrics.default.scaledFont(for: customFont)
    }
}
