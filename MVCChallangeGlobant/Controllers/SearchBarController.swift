//
//  SearchBarController.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 19/12/24.
//

import Foundation
import UIKit
import SwiftUI

protocol CarSearchDelegate: AnyObject{
    
    typealias DidFilterHandler = (_ result: [Any]) -> Void
    var dataSource: [Any] {get set}
    var didFilterHandler: DidFilterHandler? {get set}
    func filterMovies(searchText: String)
    func updateMovieListPage()
    
}

class SearchBarController: UIViewController {
    
    var movieListPage: [Movie] = []
    
    private var movieService: MovieListService
    
    init(movieService: MovieListService = MovieListService()) {
        
        self.movieService = movieService
        super.init(nibName: nil, bundle: nil)
        fetchMovieList()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var dataSource: [Any] {
        get {
            return movieListPage.map { $0 as Any }
        }
        set {
            
            if let newMovies = newValue as? [Movie] {
                print("changing to new movies")
                
            } else {
                
                print("Error: Unable to cast to [Movie]")
                
            }
        }
    }
    
    var didFilterHandler: DidFilterHandler?
}

extension SearchBarController: CarSearchDelegate {
    func updateMovieListPage() {
        print("gu")
    }
    
    
    func filterMovies(searchText: String) {
        
        var result: [Any] = self.movieListPage.filter({$0.title.localizedCaseInsensitiveContains(searchText)})
        result = !result.isEmpty ? result :
        ["No se encontraron resultados"]
        
        self.dataSource = result
        
        didFilterHandler?(result)
        
        print(movieListPage)
        
        }
    
}

extension SearchBarController {
    
    /* func createSearchbarView() -> some View {
        SearchView(movieListPage: movieListPage, movieViewController: self)
        } */
}

extension SearchBarController {
    
    func fetchMovieList(language: String = "en") {
        
        movieService.getMoviesList(page: 1, language: language) { [weak self] movieListResponse in
            
            
                if let movies = movieListResponse {
            
                    self?.movieListPage = movies.results.toMovies
                    
                } else {
                    
                    print("error")
                }
                
            
        }
    }
}

extension MovieGridViewController{
    
    class func buildSearchBar() -> SearchBarController {
        
        let searchBarController = SearchBarController()
        
        searchBarController.tabBarItem.image = UIImage(systemName: "list.bullet.rectangle")
        
        return searchBarController
        
    }
}


struct MovieGridControllerWrapper<VC: UIViewController>: UIViewControllerRepresentable {
    var viewController: VC

    func makeUIViewController(context: Context) -> VC {
        return viewController
    }

    func updateUIViewController(_ uiViewController: VC, context: Context) {
        // Update the UI if needed
    }
}

