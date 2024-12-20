//
//  SearchTextLabel.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 19/12/24.
//

import SwiftUI

struct SearchTextLabel: View {
    
    @Binding var inputText: String
    var searchLabelDelegate: CarSearchDelegate?
    

    var body: some View {
        TextLabelInput(inputText: $inputText, enterText: "Enter movie")
            .onChange(of: inputText) { oldState, newState in
                
                print("old state search text label: \(oldState)")
                print("new State search text label: \(newState)")
                
                searchLabelDelegate?.inputText = newState
                searchLabelDelegate?.filterMovies(searchText: newState)
                searchLabelDelegate?.updateMovieListPage()
        
            }
    
            .padding()
    }
}

#Preview {
    SearchView(movieListPage: [], updateDelegate: MovieSearchViewController(viewType: .grid))
}
