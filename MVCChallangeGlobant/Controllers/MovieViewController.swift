//
//  MovieViewController.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 28/11/24.
//

import Foundation
import SwiftUI
import UIKit
import Combine

protocol MovieServiceDelegate{
    
    func getMovieService(movieTotalResponse: Int, movieList: [MovieResponseDTO?])
    
}

struct MovieViewBuilder {
    static func makeContentView() -> some View {
        let movieViewController = MovieViewController()
        return movieViewController.createContentView()
    }
}

protocol PageDelegate: AnyObject {
    var page: Int { get set }
    var totalResponses: Int { get set }
    
    func nextPage()
    func previousPage()
    func getMovieList() -> [MovieResponseDTO?]
}

class MovieViewController: UIViewController {
    
    var page: Int = 1
    var totalResponses: Int = 500
    var movieListPage: [MovieResponseDTO?] = []
    private var movieService: MovieListService
    
    func getPosterView(for posterPath: String) -> some View {
        return movieService.getAsyncImage(posterPath: posterPath)
    }
    
    init(movieService: MovieListService = MovieListService()){
        print("service made")
        self.movieService = movieService
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
                    // Replace this with your actual SwiftUI view
            self.createGridView()
                }
        
    }
    
   
}

extension MovieViewController : PageDelegate {
    
    func nextPage() {
        if page < totalResponses {
            page += 1
            fetchMovieList()
            
        }
        print(page)
    }
    
    func getMovieList() -> [MovieResponseDTO?] {
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

extension MovieViewController : MovieServiceDelegate {
    
    func getMovieService(movieTotalResponse: Int, movieList: [MovieResponseDTO?]) {
        
        
        DispatchQueue.main.async { [weak self] in
            self?.movieListPage = movieList
            self?.totalResponses = movieTotalResponse
            self?.updateMovieListPage()
        }
    }
    
    

    

}

extension MovieViewController {
    
    func createGridView() -> some View {
        
            var gridLayoutView =
               GridLayoutView(
                    listOfMovies: movieListPage.toMovies
                )
                        
        gridLayoutView.delegate = self
            
        
        return gridLayoutView
        
    }
    
    
    func createContentView() -> some View {
        
            var contentView =
                ContentView(
                    listOfMovies: movieListPage.toMovies
                )
        
        contentView.delegate = self
        
        
        return contentView
                
            
        
    }
    
}

extension MovieViewController {
    
    func navigateToMovieDetail(movieID: Int) {
        let movieDetailVC = MovieDetailViewController(movieID: movieID)
            movieDetailVC.movieID = movieID // Set the selected movie ID
            self.navigationController?.pushViewController(movieDetailVC, animated: true) // Navigate to the movie detail view controller
        }
}

extension MovieViewController{
    
    func fetchMovieList(language: String = "en") {
        
        movieService.getMoviesList(page: page, language: language) { [weak self] movieListResponse in
            
            
                if let movies = movieListResponse {
                    
                    print(self?.totalResponses ?? 0)
                    
                    // Process the movie results
                    var listMoviesResponse: [MovieResponseDTO] = []
                    movies.results.forEach { movieFound in
                        listMoviesResponse.append(movieFound ?? MovieResponseDTO.mock)
                    }
                    
                    self?.movieListPage = listMoviesResponse
                    
                } else {
                    
                    print("error")
                }
                
            
        }
    }
    
    
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage? = nil
    var cancellable: AnyCancellable?
    
    func loadImage(from url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .tryMap { data -> UIImage? in
                guard let image = UIImage(data: data) else {
                    throw URLError(.badURL) 
                }
                return image
            }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
}


