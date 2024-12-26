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
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // Imagen y detalles principales
                MovieImageDetails(
                    titulo: movie.title,
                    voteAverage: movie.vote_average,
                    fechaDeLanzamiento: movie.release_date,
                    posterPath: movie.poster_path
                )
                
                // Géneros
                GenreListView(genres: movie.genres)
                    
                
                // Encabezado Overview
                Text("Overview")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                // Descripción de la Película
                Text(movie.overview)
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
            }
        }
//        .background(Color(.systemGroupedBackground))
        .ignoresSafeArea(edges: .top)
        .onAppear {
            print(movieId)
        }
    }
}
