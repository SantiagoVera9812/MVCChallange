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
    
    
    init(listOfMovies: [Movie]) {
        
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
        NavigationView {
            UIViewControllerWrapper(
                makeUIViewController: { MovieViewController()}
            )
            .navigationBarTitle("Login", displayMode: .inline)
            .navigationBarItems(trailing: Button("Settings") {
                // Action for Help button
                print("Help pressed")
            })
        }
    }
}

#Preview {
    
        MoviewViewWrapper()
    
}
