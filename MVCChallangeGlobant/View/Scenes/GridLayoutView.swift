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
    weak var movieChosenDelegate: MovieSelectedDelegate?
    
    
    init(listOfMovies: [Movie]) {
        self.listOfMovies = listOfMovies
    
    }
    
    var body: some View {
        
        TextLabelInput(inputText: $inputText, enterText: "Enter movie")
        
            VStack {
                
                
                    ListHorizontalMovieViews(listOfMovies: listOfMovies,  onMovieSelected: {
                        
                        movieID in
                        
                        
                    }, movieChosenDelegate: movieChosenDelegate)

            
             
               
                
                Spacer()
                HStack {
                    
                    PreviousButton{
                        delegate?.previousPage()
                    }
                    
                    NextButton {
                        delegate?.nextPage()
                        
                    }
                }
                .padding()
            }
            
    }
    
    
}

#Preview {
    
    MoviewViewWrapper()
        
    
}
