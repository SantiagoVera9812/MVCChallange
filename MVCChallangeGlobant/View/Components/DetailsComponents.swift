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

struct GenreListView: View {
    
    let genres: [Genre]
    
    var body: some View {
        
        HStack {
                    ForEach(genres.indices, id: \.self) { index in
                        Text(genres[index].name)
                        
                        if index < genres.count - 1 {
                            Text(".")
                        }
                    }
                }
                .padding()
            }
    }

struct MovieImageDetails: View {
    
    let titulo: String
    let voteAvarage: Float
    let fechaDeLanzamiento: String
    let posterPath: String
   
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack{
                
                MoviePosterView(posterPath: posterPath)
                    .scaledToFill()
                    .clipped()
                    .blur(radius: 10)
                    .opacity(0.7)
                    .frame(height: geometry.size.height * 0.5)
                    
                
                VStack{
                    HStack {
                        
                        MoviePosterView(posterPath: posterPath)
                            .scaledToFit()
                            
                            
                        
                        VStack(alignment: .leading) {
                            
                            Text(titulo)
                                .font(.title)
                                .foregroundStyle(.white)
                                .fontWeight(.bold)
                                .lineLimit(1)
                                .minimumScaleFactor(0.2)
                            
                            Text(fechaDeLanzamiento)
                                .font(.subheadline)
                                .foregroundStyle(.white)
                                .lineLimit(1)
                                .minimumScaleFactor(0.2)
                            
                            StarRatingView(rating: voteAvarage)
                                .padding(.top, 5)
                            
                        }
                        .padding(20)
                        
                    }
                }
                
                .cornerRadius(12)
                .padding()
            }
        }
    }
        
        
        
    }


