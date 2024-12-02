//
//  ContentView.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 27/11/24.
//

import SwiftUI

struct ContentView: View {
    
    let onNext: () -> Void
    let onPrevious: () -> Void
    let getMovieList: (@escaping ([MovieResponse]) -> Void) -> Void
    @State private var listOfMovies: [MovieResponse]
    @State private var isLoading: Bool
    
    init(onNext: @escaping () -> Void, onPrevious: @escaping () -> Void, getMovieList: @escaping (@escaping ([MovieResponse]) -> Void) -> Void, listOfMovies: [MovieResponse], isLoading: Bool) {
        self.onNext = onNext
        self.onPrevious = onPrevious
        self.getMovieList = getMovieList
        self.listOfMovies = listOfMovies
        self.isLoading = isLoading
        
    }
    
    var body: some View {
        
    
            VStack {
                ListHorizontalMovieViews(listOfMovies: listOfMovies)
                ListVerticallyMovieViews(listOfMovies: listOfMovies)
                
                Spacer()
                HStack {
                    PreviousButton {
                        onPrevious()
                        fetchMovies()
                    }
                    NextButton {
                        onNext()
                        fetchMovies()
                    }
                }
                .padding()
            }
            .onAppear {
                fetchMovies()
            }
        
    }
    
    private func fetchMovies() {
        getMovieList { movieList in
            
                listOfMovies = movieList
             }
    }
}

#Preview {
    
    MovieViewController.shared.createContentView()
}
