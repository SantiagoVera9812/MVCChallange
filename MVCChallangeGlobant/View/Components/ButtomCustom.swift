//
//  ButtomCustom.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 28/11/24.
//

import Foundation
import SwiftUI


struct TextButton: View {
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
        }
    }
}

struct NextButton: View {
    let action: () -> Void
    
    var body: some View {
        TextButton(label: "Next", action: action)
    }
}

struct PreviousButton: View {
    let action: () -> Void
    
    var body: some View {
        TextButton(label: "Previous", action: action)
    }
}




