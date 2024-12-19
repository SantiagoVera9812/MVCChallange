//
//  SearchTextLabel.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 19/12/24.
//

import SwiftUI

protocol movieUpdatedFromSearchBardelegate: AnyObject{
    
    func updateMovieListFromSearchbar(listOfMovies: [Movie])
}

class SearchViewModel: ObservableObject, CarSearchDelegate {
    
    func updateMovieListPage() {
        print("On Update")
    }
    
    
    @Published var movieListPage: [Movie] = []
    @Published var initialPage: [Movie] = []
    private var movieService: MovieListService
    
    init(movieService: MovieListService = MovieListService(),movieListPage: [Movie] = []) {
        self.movieService = movieService
            self.movieListPage = movieListPage
        self.initialPage = movieListPage
        
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
    @State private var inputText: String = ""
   
    weak var updateDelegat: movieUpdatedFromSearchBardelegate?
    
    init(movieListPage: [Movie], movieViewController: UIViewController) {
            _viewModel = StateObject(wrappedValue: SearchViewModel(movieListPage: movieListPage))
        
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
    SearchView(movieListPage: [], movieViewController: MovieViewController(viewType: .grid))
}
