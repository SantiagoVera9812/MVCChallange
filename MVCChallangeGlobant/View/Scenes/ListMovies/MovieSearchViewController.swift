//
//  MovieGridViewController.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 18/12/24.
//

import Foundation
import UIKit
import SwiftUI

protocol MovieServiceProtocol{
    
    func getMovieService(movieTotalResponse: Int, movieList: [MovieResponseDTO?])
    
}

protocol PageDelegate: AnyObject {
    var page: Int { get set }
    var totalResponses: Int { get set }
    
    func nextPage()
    func previousPage()
}

class MovieSearchViewController: UIViewController {
    
    var page: Int = 1
    
    var totalResponses: Int = 500
    var movieListPage: [Movie] = []
    var loginUser: AnyObject
    let language: String
    private var movieService: MovieListService
    private var viewType: ViewType
        
        enum ViewType {
            case grid
            case content
        }
    weak var updateDelegate: MovieDetailUpdateDelegate?
    
    func getPosterView(for posterPath: String) -> some View {
        return movieService.getAsyncImage(posterPath: posterPath)
    }
    
    init(movieService: MovieListService = MovieListService(), viewType: ViewType, loginUser: AnyObject, language: String = "en"){
        print("on movie grid controller")
        self.loginUser = loginUser
        self.movieService = movieService
        self.viewType = viewType
        print("langueage on init \(language)")
        self.language = language
        print("langueage on init \(language)")
        super.init(nibName: nil, bundle: nil)
        fetchMovieList(language: language)
        self.movieService.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let navigationController = self.navigationController {
                print("Navigation Controller found: \(navigationController.description)")
            print("navigation controller found \(self.loginUser)")
                
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
                    return AnyView( self.updateGridView(listOfMovies: self.movieListPage, inputText: "")) // Return the grid view
                case .content:
                    return AnyView(self.updateSimpleView(listOfMovies: self.movieListPage, inputText: "")) // Return the content view
                }
            }
        
    }
    
    
    
   
}

extension MovieSearchViewController : PageDelegate {
    
    func nextPage() {
        if page < totalResponses {
            page += 1
            fetchMovieList(language: language)
            
        }
        print(page)
    }
    
    func getMovieList() -> [Movie] {
        return movieListPage
    }
    
    func previousPage() {
        if page > 1 {
            page -= 1
            fetchMovieList(language: language)
        }
        print(page)
    }
    
    
}

extension MovieSearchViewController : MovieServiceProtocol {
    
    func getMovieService(movieTotalResponse: Int, movieList: [MovieResponseDTO?]) {
        
        
        DispatchQueue.main.async { [weak self] in
            self?.movieListPage = movieList.toMovies
            self?.totalResponses = movieTotalResponse
            self?.updateMovieListPage()
        }
    }
    
}

extension MovieSearchViewController: MovieSelectedDelegate, MovieDetailUpdateDelegate{
    
    
    func didUpdateLoginUser(_ user: AnyObject) {
        self.loginUser = user
        updateDelegate?.didUpdateLoginUser(self.loginUser)
        
    }
    
    
    func goToMovieDetails(id: Int) {
        
        let hostingController = MovieDetailViewController(movieID: id, loginUser: loginUser, registerService: CoreDataService(movieid: Int64(id)), language: language)
        
        hostingController.updateDelegate = self
        
        let navBarStyle = NavigationBarWithImageAsAButton(title: "Movie Details", rightButtonImage: UIImage(systemName: "star"))
        
        navBarStyle.configure(hostingController)
    
        self.navigationController?.pushViewController(hostingController, animated: true)
    }
    
    
}

extension MovieSearchViewController: movieUpdatedFromSearchBardelegate {
    
    
    func wrongSearchBar(inputText: String) {
        
        HostingControllerBuilder.hostingControllerCreateView(in: self) {
                // Ensure the closure returns a SwiftUI view
            
            let searchbar = self.createSearchbarView(inputText: inputText)
                
            return AnyView(
                
                VStack{
                    
                    searchbar
                    WarningNoMoviesVie(errorMsg: "No movies found with search: " + inputText)
                    
                    
                }
            
            
            ) // Return the grid view
                
                }
        
    }
    
    
    func updateMovieListFromSearchbar(listOfMovies: [Movie], inputText: String = ""){
        
        HostingControllerBuilder.hostingControllerCreateView(in: self) {
                // Ensure the closure returns a SwiftUI view
                switch self.viewType {
                case .grid:
                    return AnyView( self.updateGridView(listOfMovies: listOfMovies, inputText: inputText)) // Return the grid view
                case .content:
                    return AnyView(self.updateSimpleView(listOfMovies: listOfMovies, inputText: inputText)) // Return the content view
                }
            }
    }
}

extension MovieSearchViewController {
    
    func createSearchbarView(inputText: String = "") -> some View {
        let searchView = SearchView(movieListPage: movieListPage, updateDelegate: self, inputText: inputText)
        return searchView
        }
    
}

extension MovieSearchViewController {
    
    func searchBarController(){
        
        HostingControllerBuilder.hostingControllerCreateView(in: self) {
                // Ensure the closure returns a SwiftUI view
                
            return AnyView( self.createSearchbarView()) // Return the grid view
                
                }
            }
        
    }


extension MovieSearchViewController {
    
    
    func updateGridView(listOfMovies: [Movie], inputText: String) -> some View {

        let searchView = createSearchbarView(inputText: inputText)
        var paginator = PaginatorView()
        paginator.delegate = self
            
            // Create the grid layout view
        var gridLayoutView = GridLayoutView(listOfMovies: listOfMovies)
            gridLayoutView.movieChosenDelegate = self
            
            
            // Combine the search view and grid layout view
            return AnyView(
                
                
                    
                    VStack {
                        searchView // Display the search view
                        gridLayoutView
                        paginator// Display the grid layout view
                    }
                )
        }
    
    
    func updateSimpleView(listOfMovies: [Movie], inputText: String) -> some View {

        let searchView = createSearchbarView(inputText: inputText)
        var paginator = PaginatorView()
        paginator.delegate = self
            // Create the grid layout view
        var simpleLayoutView = ContentView(listOfMovies: listOfMovies)
            simpleLayoutView.movieChosenDelegate = self
            
            
            // Combine the search view and grid layout view
            return AnyView(VStack {
                searchView // Display the search view
                simpleLayoutView
                paginator// Display the grid layout view
            })
        }

}

extension MovieSearchViewController {
    
    class func buildSimpleList(loginUser: AnyObject, language: String = "en") -> MovieSearchViewController {
        
        print("language on buildsimplelist: \(language)")
        let movieController = MovieSearchViewController(viewType: .content, loginUser: loginUser, language: language)
        
        movieController.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle.fill")
        
        return movieController
        
    }
    
    class func buildGridList(loginUser: AnyObject, language: String = "en") -> MovieSearchViewController {
        
        print("language on build on grid: \(language)")
        let movieController = MovieSearchViewController(viewType: .grid, loginUser: loginUser, language: language)
        
        movieController.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle.fill")
        
        return movieController
        
    }
}

extension MovieSearchViewController{
    
    
    func fetchMovieList(language: String) {
        
        movieService.getMoviesList(page: page, language: language) { [weak self] movieListResponse in
                
            print("language on fetch movie list \(language)")
            
                if let movies = movieListResponse {
                    
                    print(self?.totalResponses ?? 0)
                    
                    self?.movieListPage = movies.results.toMovies
                    
                } else {
                    
                    print("error")
                }
                
            
        }
    }
    
    
}

