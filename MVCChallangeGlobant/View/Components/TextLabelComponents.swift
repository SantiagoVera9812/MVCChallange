//
//  TextLabelComponents.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 5/12/24.
//

import Foundation
import SwiftUI

struct TextLabelInput: View {
    
    @Binding var inputText: String
    let enterText: String
    
    var body: some View {
        
        TextField(enterText, text: $inputText)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
    }
}
