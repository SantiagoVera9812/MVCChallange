//
//  Functions.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 27/11/24.
//

import Foundation

func startsWithPattern(in string: String?, pattern: String) -> Bool {
    
    guard let validString = string else { return false }

    let regexPattern = "^" + NSRegularExpression.escapedPattern(for: pattern)
    
    
    guard let regex = try? NSRegularExpression(pattern: regexPattern, options: .caseInsensitive) else {
        return false
    }
    
    let range = NSRange(location: 0, length: validString.utf16.count)
    return regex.firstMatch(in: validString, options: [], range: range) != nil
}
