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

struct GenreListView: View {
    let genres: [Genre]
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(genres.indices, id: \.self) { index in
                Text(genres[index].name)
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.8))
                    .cornerRadius(8)
            }
        }
        .padding(.horizontal)
    }
}

struct MovieImageDetails: View {
    let titulo: String
    let voteAverage: Float
    let fechaDeLanzamiento: String
    let posterPath: String
   
    var body: some View {
        VStack {
            // Contenedor con fondo gris oscuro
            VStack(alignment: .center, spacing: 12) {
                MoviePosterView(posterPath: posterPath)
                    .frame(width: 150, height: 220)
                    .shadow(radius: 5)
                
                VStack(alignment: .center, spacing: 6) {
                    Text(titulo)
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                    
                    Text(fechaDeLanzamiento)
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                    StarRatingView(rating: voteAverage)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(red: 28/255, green: 28/255, blue: 30/255)) // Gris oscuro GPT
            .padding(.top, 40)
        }
    }
}
