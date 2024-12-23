//
//  GridLayoutView.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 3/12/24.
//

import Foundation
import SwiftUI

struct GridLayoutView: View {
    
    @State var inputText: String = ""
    @State private var listOfMovies: [Movie]
    weak var delegate: PageDelegate?
    weak var searchLabelDelegate: CarSearchDelegate?
    //var textLabelInput: TextLabelInput
    weak var movieChosenDelegate: MovieSelectedDelegate?
    
    
    init(listOfMovies: [Movie]/*, textLabelInput: TextLabelInput*/) {
        self.listOfMovies = listOfMovies
        //self.textLabelInput = textLabelInput
        
    }
    
    var body: some View {
        
      /*      TextLabelInput(inputText: $inputText, enterText: "Enter movie")
                .onChange(of: inputText) { oldState, newState in
                    
                    searchLabelDelegate?.filterMovies(searchText: newState)
                    
                    
                
                    
                } */
            
            
            VStack {
                
                
                ListHorizontalMovieViews(listOfMovies: listOfMovies,  onMovieSelected: {
                    
                    movieID in
                    
                    
                }, movieChosenDelegate: movieChosenDelegate)
                
                
            }
        }
    
    
    
}

#Preview {
    
    MoviewViewWrapper()
        
    
}
