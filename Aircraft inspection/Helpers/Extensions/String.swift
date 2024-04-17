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
    
    
    func formatterNumber() -> String {
//        let cleanPhoneNumber = components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
//        let kg = " kg"
//        let mark = "XX"
//        var result = ""
//        var startIndex = cleanPhoneNumber.startIndex
//        let endIndex = cleanPhoneNumber.endIndex
//        for charct in mark where startIndex < endIndex {
//            if charct == "X" {
//                result.append(cleanPhoneNumber[startIndex])
//                startIndex = cleanPhoneNumber.index(after: startIndex)
//            } else {
//                result.append(charct)
//            }
//        }
//        return result
        
        var cleanPhoneNumber = components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        let kg = " kg"
        let mark = "XX"
        var result = ""
        var startIndex = cleanPhoneNumber.startIndex
        let endIndex = cleanPhoneNumber.endIndex
        
        cleanPhoneNumber.append(kg)
        
        for charct in mark where startIndex < endIndex {
            if charct == "X" {
                result.append(cleanPhoneNumber[startIndex])
                startIndex = cleanPhoneNumber.index(after: startIndex)
                
                
            } else {
                result.append(charct)
            }
        }
        return result
    }
    
    
    
    
}
