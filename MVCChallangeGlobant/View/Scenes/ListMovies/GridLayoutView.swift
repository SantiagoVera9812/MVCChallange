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
    weak var movieChosenDelegate: MovieSelectedDelegate?
    
    
    init(listOfMovies: [Movie]) {
        self.listOfMovies = listOfMovies
       
        
    }
    
    var body: some View {
    
        ZStack {
            
            VStack {
                
                
                ListHorizontalMovieViews(listOfMovies: listOfMovies,  onMovieSelected: {
                    
                    movieID in
                    
                    
                }, movieChosenDelegate: movieChosenDelegate)
                
                
            }
        }
        
        }
        
    
    
    
}

#Preview {
    
    MoviewViewWrapper()
        
    
}
