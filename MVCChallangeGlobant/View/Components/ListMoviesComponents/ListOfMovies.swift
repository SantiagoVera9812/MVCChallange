//
//  ListOfMovies.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 30/11/24.
//

import Foundation
import SwiftUI

protocol MovieSelectedDelegate: AnyObject{
    
    func goToMovieDetails(id: Int)
}

struct ListVerticallyMovieViews: View {
    
    let listOfMovies: [Movie]
    let onMovieSelected: (Int) -> Void
    weak var movieChosenDelegate: MovieSelectedDelegate?
    
    init(listOfMovies: [Movie], onMovieSelected: @escaping (Int) -> Void, movieChosenDelegate: MovieSelectedDelegate? = nil) {
        self.listOfMovies = listOfMovies
        self.onMovieSelected = onMovieSelected
        self.movieChosenDelegate = movieChosenDelegate
        
    }
    
    
    
    var body: some View {
        
        ScrollView{
            
            VStack {
                
                    ForEach(listOfMovies, id: \.id) { movieFound in
                            MovieListViewCell(
                                movie: movieFound) { movieID in
                                    
                                    movieChosenDelegate?.goToMovieDetails(id: movieID)
                                    
                                    
                                
                                }.onTapGesture {
                                    movieChosenDelegate?.goToMovieDetails(id: movieFound.id)
                                
                                }
                        
                        
                        Spacer(minLength: 20)
                        
                    }
                
            }
            .scaledToFit()
            
        }
        
    }
}

struct ListHorizontalMovieViews: View {
    
    let listOfMovies: [Movie]
    let onMovieSelected: (Int) -> Void
    weak var movieChosenDelegate: MovieSelectedDelegate?
    
    init(listOfMovies: [Movie], onMovieSelected: @escaping (Int) -> Void, movieChosenDelegate: MovieSelectedDelegate? = nil) {
        self.listOfMovies = listOfMovies
        self.onMovieSelected = onMovieSelected
        self.movieChosenDelegate = movieChosenDelegate
        
    }
    
  // Define the number of columns for the grid
  let columns = [
    GridItem(.flexible(), spacing: 5),
    GridItem(.flexible(), spacing: 5),
    GridItem(.flexible(), spacing: 5)
  ]
  var body: some View {
      ZStack {
          AppTheme.AppColors.background.ignoresSafeArea(.all)
          ScrollView {
              LazyVGrid(columns: columns, spacing: 5) { // Uniform spacing between rows
                  ForEach(listOfMovies, id: \.id) { movieFound in
                      VStack {
                          
                          HorizontalMovieView(
                            
                            movie: movieFound
                          ) { movieID in
                              
                              print(movieID)
                              movieChosenDelegate?.goToMovieDetails(id: movieID)
                              
                          }.onTapGesture {
                              
                              movieChosenDelegate?.goToMovieDetails(id: movieFound.id)
                          }
                          
                          .aspectRatio(2/3, contentMode: .fill) // Fixed aspect ratio for the images
                          .cornerRadius(12) // Rounded corners for each movie poster
                          .shadow(radius: 6) // Add shadow for a sleek look
                          
                      }
                  }
              }
              .padding(5) // Padding around the grid
              .scaledToFit()
          }
      }
  }
}
