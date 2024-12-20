//
//  ContentView.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 27/11/24.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var listOfMovies: [Movie]
    @State var inputText: String = ""
    weak var delegate: PageDelegate?
    weak var movieChosenDelegate: MovieSelectedDelegate?
    
    
    init(listOfMovies: [Movie]) {
        
        self.listOfMovies = listOfMovies
        
        
    }
    
    var body: some View {
        
            VStack {
                
                ListVerticallyMovieViews(listOfMovies: listOfMovies,  onMovieSelected: {
                        
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

struct MoviewViewWrapper: View {
    var body: some View {
        
            UIViewControllerWrapper(
                makeUIViewController: { MovieViewController.buildGridList()}
            )
            .navigationBarTitle("Login", displayMode: .inline)
            .navigationBarItems(trailing: Button("Settings") {
                // Action for Help button
                print("Help pressed")
            })
        
    }
}

#Preview {
    
        MoviewViewWrapper()
    
}
