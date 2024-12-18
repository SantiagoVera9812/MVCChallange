//
//  MovieGridViewController.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 18/12/24.
//

import Foundation
import UIKit
import SwiftUI


protocol CarSearchDelegate: AnyObject{
    
    typealias DidFilterHandler = (_ result: [Any]) -> Void
    var dataSource: [Any] {get set}
    var didFilterHandler: DidFilterHandler? {get set}
    func filterMovies(searchText: String)
    
}

extension MovieGridViewController: CarSearchDelegate {
    
    func filterMovies(searchText: String) {
        
        var result: [Any] = self.movieListPage.filter({$0.title.localizedCaseInsensitiveContains(searchText)})
        result = !result.isEmpty ? result :
        ["No se encontraron resultados"]
        
        self.dataSource = result
        
        didFilterHandler?(result)
        
        print(movieListPage)
        
        }
    
}

class MovieGridViewController: UIViewController {
    
    var dataSource: [Any] {
            get {
                return movieListPage.map { $0 as Any }
            }
            set {
                
                if let newMovies = newValue as? [Movie] {
                    print("changing to new movies")
                    movieListPage = newMovies
                } else {
                    
                    print("Error: Unable to cast to [Movie]")
                }
            }
        }
    
    var didFilterHandler: DidFilterHandler? 
    
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

extension MovieGridViewController {
    
    func createGridView() -> some View {
        
        let movies: [Movie] = movieListPage
        
            var gridLayoutView =
               GridLayoutView(
                listOfMovies: movies
                    //textLabelInput: TextLabelInput(inputText: <#T##Binding<String>#>, enterText: <#T##String#>)
                )
                        
        gridLayoutView.delegate = self
        gridLayoutView.movieChosenDelegate = self
        gridLayoutView.searchLabelDelegate = self
            
        
        return gridLayoutView
        
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
        
        movieController.tabBarItem.image = UIImage(systemName: "list.bullet.rectangle")
        
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

