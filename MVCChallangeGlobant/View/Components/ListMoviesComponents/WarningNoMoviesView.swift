//
//  WarningNoMoviesView.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 18/12/24.
//

import Foundation
import SwiftUI

struct WarningNoMoviesVie: View {
    
    let errorMsg: String
    
    var body: some View {
        
        VStack {
            
            let background = RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.white)
                .shadow(radius: 5)
            
            
            VStack {
                Text(Image(systemName: "exclamationmark.triangle"))
                    .padding()
                    
                Text(errorMsg)
                    .padding()
                    .background(background)
            }
            .font(.largeTitle)
            
        }
    }
        
        
}

#Preview {
    WarningNoMoviesVie(errorMsg: "No movies found")
}
