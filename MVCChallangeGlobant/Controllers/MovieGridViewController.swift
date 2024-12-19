//
//  MovieGridViewController.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 18/12/24.
//

import Foundation
import UIKit
import SwiftUI

class MovieGridViewController: UIViewController {
    
    var page: Int = 1
    
    var totalResponses: Int = 500
    var movieListPage: [Movie] = []
    private var movieService: MovieListService
    private var viewType: ViewType
        
        enum ViewType {
            case grid
            case content
        }
    
    func getPosterView(for posterPath: String) -> some View {
        return movieService.getAsyncImage(posterPath: posterPath)
    }
    
    init(movieService: MovieListService = MovieListService(), viewType: ViewType){
        print("on movie grid controller")
        self.movieService = movieService
        self.viewType = viewType
        super.init(nibName: nil, bundle: nil)
        fetchMovieList()
        self.movieService.delegate = self
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let navigationController = self.navigationController {
                print("Navigation Controller found: \(navigationController.description)")
                
            } else {
                print("No navigation controller found.")
            }
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
        }

    //Esta funcion se llamara cuando se termine el llamado a la api
    
    func updateMovieListPage(){
        
        HostingControllerBuilder.hostingControllerCreateView(in: self) {
                // Ensure the closure returns a SwiftUI view
                switch self.viewType {
                case .grid:
                    return AnyView( self.createGridView()) // Return the grid view
                case .content:
                    return AnyView(self.createContentView()) // Return the content view
                }
            }
        
    }
    
    
    
   
}

extension MovieGridViewController : PageDelegate {
    
    func nextPage() {
        if page < totalResponses {
            page += 1
            fetchMovieList()
            
        }
        print(page)
    }
    
    func getMovieList() -> [Movie] {
        return movieListPage
    }
    
    func previousPage() {
        if page > 1 {
            page -= 1
            fetchMovieList()
        }
        print(page)
    }
    
    
}

extension MovieGridViewController : MovieServiceProtocol {
    
    func getMovieService(movieTotalResponse: Int, movieList: [MovieResponseDTO?]) {
        
        
        DispatchQueue.main.async { [weak self] in
            self?.movieListPage = movieList.toMovies
            self?.totalResponses = movieTotalResponse
            self?.updateMovieListPage()
        }
    }
    
}

extension MovieGridViewController: MovieSelectedDelegate{
    
    func goToMovieDetails(id: Int) {
        
        let hostingController = MovieDetailViewController(movieID: id)
    
        self.navigationController?.pushViewController(hostingController, animated: true)
    }
    
    
}

extension MovieGridViewController: movieUpdatedFromSearchBardelegate {
    
    func updateMovieListFromSearchbar(listOfMovies: [Movie], inputText: String = ""){
        
        HostingControllerBuilder.hostingControllerCreateView(in: self) {
                // Ensure the closure returns a SwiftUI view
                switch self.viewType {
                case .grid:
                    return AnyView( self.updateGridView(listOfMovies: listOfMovies, inputText: inputText)) // Return the grid view
                case .content:
                    return AnyView(self.createContentView()) // Return the content view
                }
            }
    }
}

extension MovieGridViewController {
    
    func createSearchbarView(inputText: String = "") -> some View {
        var searchView = SearchView(movieListPage: movieListPage, updateDelegate: self, inputText: inputText)
        return searchView
        }
    
}

extension MovieGridViewController {
    
    func searchBarController(){
        
        HostingControllerBuilder.hostingControllerCreateView(in: self) {
                // Ensure the closure returns a SwiftUI view
                
            return AnyView( self.createSearchbarView()) // Return the grid view
                
                }
            }
        
    }


extension MovieGridViewController {
    
    func updateGridView(listOfMovies: [Movie], inputText: String) -> some View {

        let searchView = createSearchbarView(inputText: inputText)
            
            // Create the grid layout view
        var gridLayoutView = GridLayoutView(listOfMovies: listOfMovies)
            gridLayoutView.delegate = self
            gridLayoutView.movieChosenDelegate = self
            
            
            // Combine the search view and grid layout view
            return AnyView(VStack {
                searchView // Display the search view
                gridLayoutView // Display the grid layout view
            })
        }
    
    
    
        func createGridView() -> some View {
                let movies: [Movie] = movieListPage
                
                // Create the search view
            let searchView = createSearchbarView()
                
                // Create the grid layout view
                var gridLayoutView = GridLayoutView(listOfMovies: movies)
                gridLayoutView.delegate = self
                gridLayoutView.movieChosenDelegate = self
                
                // Combine the search view and grid layout view
                return AnyView(VStack {
                    searchView // Display the search view
                    gridLayoutView // Display the grid layout view
                })
            }
        
    
    
    
    func createContentView() -> some View {
        
        let movies: [Movie] = movieListPage
        
            var contentView =
                ContentView(
                    listOfMovies: movies
                )
        
        contentView.delegate = self
        contentView.movieChosenDelegate = self
        
        
        
        return contentView
                
            
        
    }
    
}

extension MovieGridViewController{
    
    class func buildSimpleList() -> MovieGridViewController {
        
        let movieController = MovieGridViewController(viewType: .content)
        
        movieController.tabBarItem.image = UIImage(systemName: "list.bullet.rectangle")
        
        return movieController
        
    }
    
    class func buildGridList() -> MovieGridViewController {
        
        let movieController = MovieGridViewController(viewType: .grid)
        
        movieController.tabBarItem.image = UIImage(systemName: "square.grid.3x3")
        
        return movieController
        
    }
}

extension MovieGridViewController{
    
    func fetchMovieList(language: String = "en") {
        
        movieService.getMoviesList(page: page, language: language) { [weak self] movieListResponse in
            
            
                if let movies = movieListResponse {
                    
                    print(self?.totalResponses ?? 0)
                    
                    self?.movieListPage = movies.results.toMovies
                    
                } else {
                    
                    print("error")
                }
                
            
        }
    }
    
    
}

