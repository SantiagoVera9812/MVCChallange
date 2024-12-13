//
//  ContentView.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 27/11/24.
//

import SwiftUI

struct ContentView: View {
    
    typealias doSomething = () -> Void
    
    private let onNext: doSomething
    private let onPrevious: doSomething
    

    @State private var listOfMovies: [Movie]
    @State var inputText: String = ""
    
    
    init(onNext: @escaping doSomething, onPrevious: @escaping doSomething, listOfMovies: [Movie]) {
        self.onNext = onNext
        self.onPrevious = onPrevious
        self.listOfMovies = listOfMovies
        
        
    }
    
    var body: some View {
        
            VStack {
                
                TextLabelInput(inputText: $inputText, enterText: "Enter a movie")
                
                NavigationView{
                    ListVerticallyMovieViews(listOfMovies: listOfMovies){
                        
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
