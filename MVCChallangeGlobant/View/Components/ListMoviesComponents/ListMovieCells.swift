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
                        .font(.headline)
                        .fontWeight(.bold)
                        .lineLimit(1)
//                        .minimumScaleFactor(0.5)
                    
                    Text(movie.release_date)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .lineLimit(1)
//                        .minimumScaleFactor(0.5)
                    
                    HStack {
                        Text(String(format: "%.1f", movie.vote_average))
                            .foregroundColor(.yellow)
                            .bold()
                        
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                    
//                    StarRatingView(rating: movie.vote_average)
//                        .padding(.top, 5)
                    
                }
                .onTapGesture {
                    onMovieSelected(movie.id)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .onTapGesture {
                onMovieSelected(movie.id)
            }
            
        }
        .padding(.leading)
        
//        .background(.ultraThinMaterial)
        .cornerRadius(12)
//        .shadow(radius: 5)
        
    }
}

struct HorizontalMovieView: View {
    
    
    let movie: Movie
    let onMovieSelected: (Int) -> Void
    
    var body: some View {
        
        VStack{
            
            MoviePosterView(posterPath: movie.poster_path)
            
            VStack {
                
                
//                Text(movie.title)
//                    .font(.footnote)
//                    .fontWeight(.bold)
//                
//                Text(movie.release_date)
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
                
            }
            .onTapGesture {
                onMovieSelected(movie.id)
            }
            .padding(.bottom)
        }
        .onTapGesture {
            onMovieSelected(movie.id)
        }
//        .background(.ultraThinMaterial)
//        .cornerRadius(12)
//        .shadow(radius: 5)
//        .padding()
    }
}
