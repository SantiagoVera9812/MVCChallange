//
//  SearchTextLabel.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 19/12/24.
//

import SwiftUI

protocol movieUpdatedFromSearchBardelegate: AnyObject{
    
    func updateMovieListFromSearchbar(listOfMovies: [Movie], inputText: String)
}

class SearchViewModel: ObservableObject, CarSearchDelegate {
    
    weak var updateDelegat: movieUpdatedFromSearchBardelegate?
    
    func updateMovieListPage() {
        print("On Update")
        updateDelegat?.updateMovieListFromSearchbar(listOfMovies: movieListPage, inputText: "")
    }
    
    
    @Published var movieListPage: [Movie] = []
    @Published var initialPage: [Movie] = []
    private var movieService: MovieListService
    
    init(movieService: MovieListService = MovieListService(),movieListPage: [Movie] = [], updateDelegate: movieUpdatedFromSearchBardelegate? = nil) {
        self.movieService = movieService
            self.movieListPage = movieListPage
        self.initialPage = movieListPage
        self.updateDelegat = updateDelegate
        
        }
    
    
    func filterMovies(searchText: String) {
        
        var result: [Any] = self.movieListPage.filter({$0.title.localizedCaseInsensitiveContains(searchText)})
        result = !result.isEmpty ? result :
        ["No se encontraron resultados"]
        
        self.dataSource = result
        
        didFilterHandler?(result)
        
        
    }
    
    
    var dataSource: [Any] {
            get {
                return movieListPage.map { $0 as Any }
            }
            set {
                
                if let newMovies = newValue as? [Movie] {
                    print("changing to new movies")
                    movieListPage = newMovies
                    print(movieListPage)
        
                } else {
                    
                    print(initialPage)
                    print("Error: Unable to cast to [Movie]")
                    movieListPage = initialPage
                    
                    
                    
                }
            }
        }
    
    
    
    
    var didFilterHandler: DidFilterHandler?
}

struct SearchView: View {
    
    @StateObject var viewModel = SearchViewModel() // Initialize the ViewModel
    @State private var inputText: String
       
    init(movieListPage: [Movie], updateDelegate: movieUpdatedFromSearchBardelegate?, inputText: String = "") {
        _viewModel = StateObject(wrappedValue: SearchViewModel(movieListPage: movieListPage, updateDelegate: updateDelegate))
        self.inputText = inputText
        }
    
    var body: some View {
        VStack {
            SearchTextLabel(inputText: $inputText, searchLabelDelegate: viewModel)
            
        }.onReceive(viewModel.$movieListPage) { updatedMovies in
            
            //updateDelegat?.updateMovieListFromSearchbar(listOfMovies: updatedMovies)
        }
        
    }
}

struct SearchTextLabel: View {
    
    @Binding var inputText: String
    var searchLabelDelegate: CarSearchDelegate?

    var body: some View {
        TextLabelInput(inputText: $inputText, enterText: "Enter movie")
            .onChange(of: inputText) { oldState, newState in
                
                searchLabelDelegate?.filterMovies(searchText: newState)
                searchLabelDelegate?.updateMovieListPage()
            }
    
            .padding()
    }
}

#Preview {
    SearchView(movieListPage: [], updateDelegate: MovieGridViewController(viewType: .grid))
}
