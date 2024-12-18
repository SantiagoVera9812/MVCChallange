//
//  MovieResponse.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 27/11/24.
//

import Foundation

struct MovieListResponseDTO: Decodable{
    
    let page: Int?
    let total_pages: Int?
    let results: [MovieResponseDTO?]
}

struct MovieResponseDTO: Decodable {
    
    let id: Int?
    let release_date: String?
    let title: String?
    let vote_average: Float?
    let poster_path: String?
    
}

extension MovieResponseDTO{
    
    static var mock: MovieResponseDTO{
        MovieResponseDTO(id: 1, release_date: "", title: "", vote_average: 0.0, poster_path: "")
    }
}

extension Array where Element == MovieResponseDTO?{
    
        var toMovies: [Movie] {
            get {
                self.map { Movie(dto: $0 ?? MovieResponseDTO.mock) }
            }
            set {
                self.toMovies = newValue
            }
        }
}
