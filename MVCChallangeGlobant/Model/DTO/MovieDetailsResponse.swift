//
//  MovieDetailsResponse.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 27/11/24.
//

import Foundation

struct MovieDetailsResponseDTO: Decodable{
    
    let title: String?
    let status: String?
    let vote_average: Float?
    let release_date: String?
    var overview: String?
    let genres: [GenreDTO?]
    let poster_path: String?
}

extension MovieDetailsResponseDTO{
    
    static var mock: MovieDetailsResponseDTO{
        
        MovieDetailsResponseDTO(title: "", status: "", vote_average: 0.0, release_date: "", genres: [], poster_path: "")
    }
}


struct GenreDTO: Decodable{
    
    let id: Int?
    let name: String?
}
