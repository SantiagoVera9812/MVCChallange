//
//  ContentView.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 27/11/24.
//

import SwiftUI

struct ContentView: View {
    
    private let movieService = MovieService()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            
            movieService.getMoviesList(page: 1, language: "en") {  movieListResponse in
                
                DispatchQueue.main.async{
                    
                    if let movies = movieListResponse {
                        
                        var listMoviesResponse: [MovieResponse] = []
                        
                        movies.results.forEach{movieFound in
                            
                            listMoviesResponse.append(movieFound)
                        }
                        
                        print(listMoviesResponse)
                        
                        
                    } else {
                        
                        print("error")
                        
                    }
                }
            }
        }
    }
}

#Preview {
    
    
}
