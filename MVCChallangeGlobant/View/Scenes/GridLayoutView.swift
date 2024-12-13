//
//  GridLayoutView.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 3/12/24.
//

import Foundation
import SwiftUI

struct GridLayoutView: View {
    
    typealias doSomething = () -> Void
    
    
    @State var inputText: String = ""
    private let onNext: doSomething
    private let onPrevious: doSomething
    @State private var listOfMovies: [Movie]
    
    
    init(onNext: @escaping doSomething, onPrevious: @escaping doSomething, listOfMovies: [Movie]) {
        self.onNext = onNext
        self.onPrevious = onPrevious
        self.listOfMovies = listOfMovies
    
    }
    
    var body: some View {
        
        TextLabelInput(inputText: $inputText, enterText: "Enter movie")
        
            VStack {
                
                
                NavigationView{
                    ListHorizontalMovieViews(listOfMovies: listOfMovies){
                        
                        movieID in
                        
                        
                    }
                }.navigationTitle("Movies")
             
               
                
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
