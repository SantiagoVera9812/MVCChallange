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
        
            TextLabelInput(inputText: $inputText, enterText: "Enter movie")
                .onChange(of: inputText) { oldState, newState in
                    
                    
                    /*var result: [Any] = self.listOfMovies.filter({$0.title.localizedCaseInsensitiveContains(newState)})
                    result = !result.isEmpty ? result :
                    ["No se encontraron resultados"]*/
                    searchLabelDelegate?.filterMovies(searchText: newState)
                    
                    
                
                    
                }
            
            
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
