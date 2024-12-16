//
//  Movie.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 12/12/24.
//

import Foundation

struct MovieList {
    
    let page: Int
    let total_pages: Int
    let results: [Movie]
}

struct Movie {
    
    let id: Int
    let release_date: String
    let title: String
    let vote_average: Float
    let poster_path: String
    
    init(dto: MovieResponseDTO) {
        self.id = dto.id ?? 1
        self.release_date = dto.release_date ?? ""
        self.title = dto.title ?? ""
        self.vote_average = dto.vote_average ?? 0
        self.poster_path = dto.poster_path ?? ""
    }
    
}
