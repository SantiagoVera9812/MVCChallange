//
//  ContentView.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 27/11/24.
//

import SwiftUI

struct ContentView: View {
    
    private let onNext: () -> Void
    private let onPrevious: () -> Void
    private let getMovieList: (@escaping ([MovieResponse]) -> Void) -> Void
    @State private var listOfMovies: [MovieResponse]
    
    
    init(onNext: @escaping () -> Void, onPrevious: @escaping () -> Void, getMovieList: @escaping (@escaping ([MovieResponse]) -> Void) -> Void, listOfMovies: [MovieResponse]) {
        self.onNext = onNext
        self.onPrevious = onPrevious
        self.getMovieList = getMovieList
        self.listOfMovies = listOfMovies
        
        
    }
    
    var body: some View {
        
            VStack {
                
                ListVerticallyMovieViews(listOfMovies: listOfMovies)
                
                Spacer()
                HStack {
                    
                    PreviousButton{
                        onPrevious()
                    }
                    
                    NextButton {
                        onNext()
                        
                    }
                }
                .padding()
            }
            
    }
    
    
}

#Preview {
    
    ViewControllerWrapper()
    
}
