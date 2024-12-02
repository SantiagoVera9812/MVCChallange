//
//  MovieViewController.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 28/11/24.
//

import Foundation
import SwiftUI
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

class MovieViewController: PageDelegate, ObservableObject {
    
    static let shared = MovieViewController()
    
    @Published var page: Int = 1
    @Published var totalResponses: Int = 500
    @Published var movieListPage: [MovieResponse] = []
    @Published var isLoading: Bool = true
    private let movieService = MovieService()
    
    func getPosterView(for posterPath: String) -> some View {
        return movieService.getAsyncImage(posterPath: posterPath)
    }
    
    func nextPage() {
        if page < totalResponses {
            page += 1
            fetchMovieList(language: "en")
        }
        print(page)
    }
    
    func getMovieList() -> [MovieResponse] {
        return movieListPage
    }
    
    func checkIsLoading() -> Bool {
        return isLoading
    }
    
    func previousPage() {
        if page > 1 {
            page -= 1
            fetchMovieList(language: "en")
        }
        print(page)
    }
    
    init(){
        print("controller initializing")
        getTotalResponses()
        fetchMovieList()
        
    }
    
    private func getTotalResponses(language: String = "en") {
        movieService.getMoviesList(page: 1, language: language){
            [weak self] movieListResponse in
            
            DispatchQueue.main.async{
                
                if let movies = movieListResponse {
                    self?.totalResponses = movies.total_pages
                } else {
                    print("error")
                }
            }
            
        } }
    
    func fetchMovieList(language: String = "en") {
        movieService.getMoviesList(page: page, language: language) { [weak self] movieListResponse in
            
            DispatchQueue.main.async {
                if let movies = movieListResponse {
                    
                    print(self?.totalResponses ?? 0)
                    
                    // Process the movie results
                    var listMoviesResponse: [MovieResponse] = []
                    movies.results.forEach { movieFound in
                        listMoviesResponse.append(movieFound)
                    }
                    
                    self?.movieListPage = listMoviesResponse
                    print(self?.movieListPage ?? "no movies")
                    
                    
                    
                } else {
                    
                    print("error")
                }
                
                self?.isLoading = false
            }
        }
    }
    
    func fetchMovieDetailsList(idMovie: Int, language: String) {
        movieService.getMovieDetails(idMovie: idMovie, language: language) { [weak self] movieListResponse in
            
            DispatchQueue.main.async {
                if let movies = movieListResponse {
                    print(movies.genres)
                } else {
                    print("error")
                }
            }
        }
    }
    
    func createContentView() -> some View {
        
        if self.isLoading {
            return AnyView(
                LoadingView()
                    .onAppear {
                        
                        
                        
                    }
            )
        } else {
            return AnyView(
                ContentView(
                    onNext: { self.nextPage() },
                    onPrevious: { self.previousPage() },
                    getMovieList: { completion in
                        completion(self.getMovieList())
                    },
                    listOfMovies: movieListPage,
                    isLoading: isLoading
                )
                .onAppear {
                    // Perform any actions needed when the content view appears
                }
            )
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


