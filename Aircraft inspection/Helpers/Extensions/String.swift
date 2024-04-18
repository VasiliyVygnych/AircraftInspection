//
//  String.swift
//  Aircraft inspection
//
//  Created by Vasiliy Vygnych on 30.03.2024.
//

import Foundation

extension String {
    func addingMask(value: String,
                    mask: String) -> String {
        let cleanValue = value.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var result = ""
        var index = cleanValue.startIndex
        for ch in mask where index < cleanValue.endIndex {
        if ch == "*" {
            result.append(cleanValue[index])
            index = cleanValue.index(after: index)
        } else {
            result.append(ch)
            }
        }
        return result
    }  
}
