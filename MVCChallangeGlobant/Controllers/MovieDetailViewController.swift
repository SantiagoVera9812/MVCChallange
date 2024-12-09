//
//  MovieDetailViewController.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 6/12/24.
//

import Foundation
import UIKit
import SwiftUI

protocol MovieDetailsServiceDelegate{
    
    func getMovieDetails(movieDetails: MovieDetailsResponse)
}

protocol DetailFetchDelegate: AnyObject{
    
    var movieID: Int {get set}
    var movieDetails: MovieDetailsResponse? { get set}
    
    func fetchMovieDetailsList(idMovie: Int, language: String)
}

class MovieDetailViewController: UIViewController, DetailFetchDelegate {
    
    var movieID: Int
    
    var movieDetails: MovieDetailsResponse? = nil
    
    var movieListPage: [MovieDetailsResponse] = []
    private var movieService: MovieDetailsService
    
    init(movieID: Int, movieService: MovieDetailsService = MovieDetailsService()){
        
        print("en detail controller")
        
        self.movieID = movieID
        self.movieService = movieService
        print(self.movieID)
        super.init(nibName: nil, bundle: nil)
        fetchMovieDetailsList(idMovie: movieID, language: "en")
        self.movieService.delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}



extension MovieDetailViewController: MovieDetailsServiceDelegate {
    
    
    func getMovieDetails(movieDetails: MovieDetailsResponse) {
        
        DispatchQueue.main.async { [weak self] in
            self?.movieDetails = movieDetails
            self?.updateMovieListPage()
        }
        
    }
    
    func updateMovieListPage(){
        print("update movie List")
        print(self.movieDetails)
        
        let hostingController = UIHostingController(rootView: createMovieDetails())
        
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        
        hostingController.view.frame = view.bounds
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        hostingController.didMove(toParent: self)
    }
    
}

extension MovieDetailViewController{
    
    func createMovieDetails() -> some View {
        
            return AnyView(
                MovieDetails(movieId: movieID, movie: movieDetails)
            )
        
    }
    
}

extension MovieDetailViewController {
    
    func fetchMovieDetailsList(idMovie: Int, language: String) {
        movieService.getMovieDetails(idMovie: idMovie, language: language) { [weak self] movieListResponse in
            
            DispatchQueue.main.async {
                if let movies = movieListResponse {
                    
                    self?.movieDetails = movies
                } else {
                    print("error")
                }
            }
        }
    }
}
