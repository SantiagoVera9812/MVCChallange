//
//  ListOfMovies.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 30/11/24.
//

import Foundation
import SwiftUI

struct ListVerticallyMovieViews: View {
    
    let listOfMovies: [Movie]
    let onMovieSelected: (Int) -> Void
    
    
    var body: some View {
        
        ScrollView{
            
            VStack {
                
                    ForEach(listOfMovies, id: \.id) { movieFound in
                        NavigationLink(destination: DetailsControllerWrapper(movieId: movieFound.id ?? 1)){
                            MovieListViewCell(
                                movie: movieFound) { movieID in
                                    
                                    
                                
                                }
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
    
  // Define the number of columns for the grid
  let columns = [
    GridItem(.flexible(), spacing: 5),
    GridItem(.flexible(), spacing: 5)
  ]
  var body: some View {
    ScrollView {
      LazyVGrid(columns: columns, spacing: 5) { // Uniform spacing between rows
        ForEach(listOfMovies, id: \.id) { movieFound in
          VStack {
              
              NavigationLink(destination: DetailsControllerWrapper(movieId: movieFound.id)){
                  HorizontalMovieView(
                    
                    movie: movieFound
                  ) { movieID in
                      
                      print(movieID)
                      
                  }
                  
                  .aspectRatio(2/3, contentMode: .fill) // Fixed aspect ratio for the images
                  .cornerRadius(12) // Rounded corners for each movie poster
                  .shadow(radius: 6) // Add shadow for a sleek look
              }
          }
        }
      }
      .padding(5) // Padding around the grid
      .scaledToFit()
    }
  }
}
