//
//  DetailsView.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 6/12/24.
//

import Foundation
import SwiftUI

struct MovieDetails: View {
    
    let movieId: Int
    let movie: MovieDetail
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack {
                
                MovieImageDetails(titulo: movie.title, voteAvarage: movie.vote_average, fechaDeLanzamiento: movie.release_date, posterPath: movie.poster_path)
                    .frame(height: geometry.size.height * 0.5)
                
                GenreListView(genres: movie.genres)
                    
                
                Text("Overview")
                    .font(.title)
                    .foregroundStyle(.black)
                    .fontWeight(.bold)
                    .padding(20)
                    .lineLimit(1)
                    .minimumScaleFactor(0.2)
                
                Text(movie.overview)
                    .font(.subheadline)
                    .foregroundStyle(.black)
                    .minimumScaleFactor(0.2)
                
                
                
            }.onAppear{
                print(movieId)
            }
        }
    }
}

