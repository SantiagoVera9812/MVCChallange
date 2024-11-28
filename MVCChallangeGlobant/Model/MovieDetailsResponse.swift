//
//  MovieDetailsResponse.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 27/11/24.
//

import Foundation

struct MovieDetailsResponse: Decodable{
    
    let title: String
    let status: String
    let vote_average: Float
    let release_date: String
    var overview: String
    let genres: [Genre]
    let poster_path: String
}

struct Genre: Decodable{
    
    let id: Int
    let name: String
}
