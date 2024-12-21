//
//  MovieDetails.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 12/12/24.
//

import Foundation

class MovieDetail {
    
    let title: String
    let status: String
    let vote_average: Float
    let release_date: String
    var overview: String
    let genres: [Genre]
    let poster_path: String
    
    init(dto: MovieDetailsResponseDTO?) {
        self.title = dto?.title ?? ""
        self.status = dto?.status ?? ""
        self.vote_average = dto?.vote_average ?? 0
        self.release_date = dto?.release_date ?? ""
        self.overview = dto?.overview ?? ""
        if let genresDTO = dto?.genres {
                    self.genres = genresDTO.compactMap { genreDTO in
                        guard let id = genreDTO?.id, let name = genreDTO?.name else {
                            return nil // Skip this genre if id or name is nil
                        }
                        return Genre(id: id, name: name)
                    }
                } else {
                    self.genres = []
                }
        self.poster_path = dto?.poster_path ?? ""
    }
}

struct Genre {
    
    let id: Int
    let name: String
}
