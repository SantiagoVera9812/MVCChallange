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
        self.movieService = movieService
        super.init(nibName: nil, bundle: nil)
        fetchMovieList()
        self.movieService.delegate = self
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
        }
    
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
    
    //Esta funcion se llamara cuando se termine la
    
    func updateMovieListPage(){
        
        print(movieListPage)
        print(totalResponses)
        
        //Desde aqui es posible cambiar de la lista en horizontal (createContentView a la lista en vertical gridContentView
        let hostingController = UIHostingController(rootView: createContentView())
        
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        
        hostingController.view.frame = view.bounds
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        hostingController.didMove(toParent: self)
        
    }
    
   /* func fetchMovieDetailsList(idMovie: Int, language: String) {
        movieService.getMovieDetails(idMovie: idMovie, language: language) { [weak self] movieListResponse in
            
            DispatchQueue.main.async {
                if let movies = movieListResponse {
                    print(movies.genres)
                } else {
                    print("error")
                }
            }
        }
    } */
    
    
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
        
            return AnyView(
                GridLayoutView(
                    onNext: { self.nextPage() },
                    onPrevious: { self.previousPage() },
                    listOfMovies: movieListPage.toMovies
                    
                )
                .onAppear {
                    
                }
            )
        
    }
    
    
    func createContentView() -> some View {
        
            return AnyView(
                ContentView(
                    onNext: { self.nextPage() },
                    onPrevious: { self.previousPage() },
                    listOfMovies: movieListPage.toMovies
                    
                )
                .onAppear {
                    
                }
            )
        
    }
    
}

extension MovieViewController {
    
    func navigateToMovieDetail(movieID: Int) {
        let movieDetailVC = MovieDetailViewController(movieID: movieID)
            movieDetailVC.movieID = movieID // Set the selected movie ID
            self.navigationController?.pushViewController(movieDetailVC, animated: true) // Navigate to the movie detail view controller
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


