//
//  GridLayoutView.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 3/12/24.
//

import Foundation
import SwiftUI

struct GridLayoutView: View {
    
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
                
                ListHorizontalMovieViews(listOfMovies: listOfMovies)
               
                
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
