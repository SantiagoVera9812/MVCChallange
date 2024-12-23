//
//  String.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 23/12/24.
//

import Foundation
import UIKit

extension String {
    static func localizedString(forKey key: String) -> String {
        return NSLocalizedString(key, tableName: "Localizable", bundle: .main, value: "", comment: "")
    }
}
