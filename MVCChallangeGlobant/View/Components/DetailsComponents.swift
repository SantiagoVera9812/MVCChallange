//
//  DetailsComponents.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 28/11/24.
//

import Foundation
import SwiftUI

struct StarRatingView: View {
    var rating: Float
    var maxRating: Float = 10
    
    var body: some View {
        HStack(spacing: 3) {
            ForEach(0..<Int(maxRating), id: \.self) { index in
                Image(systemName: index < Int(rating) ? "star.fill" : "star")
                    .foregroundColor(index < Int(rating) ? .yellow : .gray)
                    .font(.system(size: 15))
            }
                    }
    }
}

struct LoadingView: View {
    var body: some View {
        ProgressView("Loading...")
    }
}


