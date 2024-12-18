//
//  HttpRequest.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 27/11/24.
//

import Foundation
import SwiftUI


class BaseMovieService {
        
    //Mover a una capa de vista
    func getAsyncImage(posterPath: String) -> some View {
        if let url = Constants.Urls.urlForMoviePoster(poster_path: posterPath) {
            return AnyView(
                
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .cornerRadius(8)
                            .frame(width: 100, height: 150)
                    } placeholder: {
                        ProgressView()
                    }
                
            )
        } else {
            // Return a placeholder or empty view if the URL is nil
            return AnyView(EmptyView())
        }
    }
    

}

extension BaseMovieService {
    
    
    
    func urlMovieService<T: Decodable>(weatherURL: URL, completion: @escaping (T?) -> Void) {
            let weatherResource = Resource<T>(url: weatherURL) { data in
    
                return try? JSONDecoder().decode(T.self, from: data)
            }
            
            WebService().load(resource: weatherResource) { result in
                if let response = result {
                    completion(response)
                    
                } else {
                    completion(nil)
                }
            }
        }
    
}

class MovieListService: BaseMovieService {
    
    var delegate: MovieServiceProtocol?
    
    func getMoviesList(page: Int, language: String, completion: @escaping (MovieListResponseDTO?) -> Void){
        
        guard let weatherURL = Constants.Urls.urlForMovieList(page: page, languague: language) else { return}
        
        urlMovieService(weatherURL: weatherURL) { [weak self] (response: MovieListResponseDTO?) in
                    completion(response)
                    if let movieList = response {
                        self?.delegate?.getMovieService(movieTotalResponse: movieList.total_pages ?? 1, movieList: movieList.results ) // Call delegate method
                    }
                }
    }
    
    
}

class MovieDetailsService: BaseMovieService {
    
    var delegate: MovieDetailsServiceDelegate?
    
    func getMovieDetails(idMovie: Int, language: String = "en", completion: @escaping (MovieDetailsResponseDTO?) -> Void) {
        
            guard let movieDetailsURL = Constants.Urls.urlForMovieIDDetails(idMovie: idMovie, languague: language) else { return }
        
        urlMovieService(weatherURL: movieDetailsURL){ [weak self] (response: MovieDetailsResponseDTO?) in
            completion(response)
            if let details = response {
                self?.delegate?.getMovieDetails(movieDetails: details) // Call delegate method
            }
        }
            
        }
    
    
}
