//
//  HttpRequest.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 27/11/24.
//

import Foundation
import SwiftUI

class MovieService {
    
    func getMoviesList(page: Int, language: String, completion: @escaping (MovieListResponse?) -> Void){
        
        guard let weatherURL = Constants.Urls.urlForMovieList(page: page, languague: language) else { return}
        
        urlMovieService(weatherURL: weatherURL, completion: completion)
    }
    
    func getMovieDetails(idMovie: Int, language: String = "en", completion: @escaping (MovieDetailsResponse?) -> Void) {
        
            guard let movieDetailsURL = Constants.Urls.urlForMovieIDDetails(idMovie: idMovie, languague: language) else { return }
        
        urlMovieService(weatherURL: movieDetailsURL, completion: completion)
            
        }
    
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

extension MovieService {
    
    private func urlMovieService<T: Decodable>(weatherURL: URL, completion: @escaping (T?) -> Void) {
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
