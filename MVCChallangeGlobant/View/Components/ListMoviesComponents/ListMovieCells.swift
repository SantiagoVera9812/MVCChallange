//
//  ListMovieCells.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 30/11/24.
//

import Foundation
import SwiftUI

struct MovieListViewCell: View{
    
    
    let movie: Movie
    let onMovieSelected: (Int) -> Void
    
    var body: some View {
        
        VStack{
            HStack {
                
                MoviePosterView(posterPath: movie.poster_path)
                
                VStack(alignment: .leading) {
                    
                    Text(movie.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    
                    Text(movie.release_date)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    
                    StarRatingView(rating: movie.vote_average)
                        .padding(.top, 5)
                    
                }
                .padding()
                
            }
        }
        .onTapGesture {
            onMovieSelected(movie.id)
        }
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .shadow(radius: 5)
        
    }
}

struct HorizontalMovieView: View {
    
    
    let movie: Movie
    let onMovieSelected: (Int) -> Void
    
    var body: some View {
        
        VStack{
            
            MoviePosterView(posterPath: movie.poster_path)
            
            VStack {
                
                
                Text(movie.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(movie.release_date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
            }
            .padding()
        }
        .onTapGesture {
            onMovieSelected(movie.id)
        }
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .shadow(radius: 5)
        .padding()
    }
}
