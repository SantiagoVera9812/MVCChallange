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
    
    func getMovieDetails(movieDetails: MovieDetailsResponseDTO?)
}

protocol DetailFetchDelegate: AnyObject{
    
    var movieID: Int {get set}
    var movieDetails: MovieDetailsResponseDTO? { get set }
    
    func fetchMovieDetailsList(idMovie: Int, language: String)
}

class MovieDetailViewController: UIViewController, DetailFetchDelegate {
    
    var movieID: Int
    var isFavorite: Bool = false {
            didSet {
                configureNavigationBar()
            }
        }
        
    var movieDetails: MovieDetailsResponseDTO? = nil
    
    var movieListPage: [MovieDetailsResponseDTO] = []
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
    
    override func viewDidLoad() {
            super.viewDidLoad()
            configureNavigationBar()
        }
        
    func configureNavigationBar() {
        
        
        let rightButton = UIBarButtonItem(image: isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), style: .plain, target: self, action: #selector(rightButtonTapped))
            self.navigationItem.rightBarButtonItem = rightButton
        }
    
    @objc func rightButtonTapped() {
        
        print("star buttom pressed")
            
        isFavorite.toggle()
        
        }
    

}



extension MovieDetailViewController: MovieDetailsServiceDelegate {
    func getMovieDetails(movieDetails: MovieDetailsResponseDTO?) {
        
        
        DispatchQueue.main.async { [weak self] in
            self?.movieDetails = movieDetails
            self?.updateMovieListPage()
        }
    }
    

    func updateMovieListPage(){
        print("update movie List")
                
        
        HostingControllerBuilder.hostingControllerCreateView(in: self) {
                    // Replace this with your actual SwiftUI view
            self.createMovieDetails()
                }
    }
    
}

extension MovieDetailViewController{
    
    func createMovieDetails() -> some View {
        
            return AnyView(
                MovieDetails(movieId: movieID, movie: MovieDetail(dto: movieDetails))
            )
        
    }
    
}

extension MovieDetailViewController {
    
    class func buildMovieDetails(movieId: Int) -> MovieDetailViewController {
        
        let movieDetailController = MovieDetailViewController(movieID: movieId)
        
        let navBarStyle = NavigationBarWithRightButton(title: "Movie Details", rightButtonTitle: "star")
        
        navBarStyle.configure(movieDetailController)
        
        return movieDetailController
        
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
