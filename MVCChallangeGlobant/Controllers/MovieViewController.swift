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
    func getMovieList() -> [MovieResponse]
}

class MovieViewController: UIViewController, PageDelegate, ObservableObject {
    
    @Published var page: Int = 1
    var totalResponses: Int = 500
    var movieListPage: [MovieResponse] = []
    private var movieService: MovieService?
    
    func getPosterView(for posterPath: String) -> some View {
        return movieService?.getAsyncImage(posterPath: posterPath)
    }
    
    func nextPage() {
        if page < totalResponses {
            page += 1
            fetchMovieList()
            
        }
        print(page)
    }
    
    func getMovieList() -> [MovieResponse] {
        return movieListPage
    }
    
    func previousPage() {
        if page > 1 {
            page -= 1
            fetchMovieList()
        }
        print(page)
    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
        movieService = MovieService()
        fetchMovieList()
        movieService?.delegate = self
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
        }
    
    func fetchMovieList(language: String = "en") {
        movieService?.getMoviesList(page: page, language: language) { [weak self] movieListResponse in
            
            DispatchQueue.main.async {
                if let movies = movieListResponse {
                    
                    print(self?.totalResponses ?? 0)
                    
                    // Process the movie results
                    var listMoviesResponse: [MovieResponse] = []
                    movies.results.forEach { movieFound in
                        listMoviesResponse.append(movieFound)
                    }
                    
                    self?.movieListPage = listMoviesResponse
                    
                } else {
                    
                    print("error")
                }
                
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
    
    func fetchMovieDetailsList(idMovie: Int, language: String) {
        movieService?.getMovieDetails(idMovie: idMovie, language: language) { [weak self] movieListResponse in
            
            DispatchQueue.main.async {
                if let movies = movieListResponse {
                    print(movies.genres)
                } else {
                    print("error")
                }
            }
        }
    }
    
    
}

extension MovieViewController : MovieServiceDelegate {
    
    func getMovieService(movieTotalResponse: Int, movieList: [MovieResponse]) {
        
        
        DispatchQueue.main.async { [weak self] in
            self?.movieListPage = movieList
            self?.totalResponses = movieTotalResponse
            self?.updateMovieListPage()
        }
    }
    
    

    
    func getMovieDetails(movieDetails: MovieDetailsResponse) {
        
        
    }
    
    
    
}

extension MovieViewController {
    
    func createGridView() -> some View {
        
            return AnyView(
                GridLayoutView(
                    onNext: { self.nextPage() },
                    onPrevious: { self.previousPage() },
                    getMovieList: { completion in
                        completion(self.getMovieList())
                    },
                    listOfMovies: movieListPage
                    
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
                    getMovieList: { completion in
                        completion(self.getMovieList())
                    },
                    listOfMovies: movieListPage
                    
                )
                .onAppear {
                    
                }
            )
        
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


