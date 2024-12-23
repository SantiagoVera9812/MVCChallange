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

protocol MovieDetailUpdateDelegate: AnyObject {
    func didUpdateLoginUser(_ user: AnyObject)
}

class MovieDetailViewController: UIViewController, DetailFetchDelegate {
    
    let registerService: enterAppDelegate
    weak var updateDelegate: MovieDetailUpdateDelegate?
    
    var movieID: Int
    var isFavorite: Bool = false {
            didSet {
                configureNavigationBar()
            }
        }
        
    var movieDetails: MovieDetailsResponseDTO? = nil
    
    var movieListPage: [MovieDetailsResponseDTO] = []
    private var movieService: MovieDetailsService
    var loginUser: AnyObject
    var userFavouriteMovies: NSSet?
    
    init(movieID: Int, movieService: MovieDetailsService = MovieDetailsService(), loginUser: AnyObject, registerService: enterAppDelegate = CoreDataService(),
         language: String = "en"){
        
        print("en detail controller")
        
        self.movieID = movieID
        self.movieService = movieService
        self.loginUser = loginUser
        self.registerService = registerService
        
        print(self.movieID)
        super.init(nibName: nil, bundle: nil)
        fetchMovieDetailsList(idMovie: movieID, language: language)
        self.movieService.delegate = self
        
        setMoviesAlreadyExist()
        isFavorite = doesMovieIdExist(in: self.userFavouriteMovies, movieId: self.movieID)
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
        
        if isFavorite == true {
            
            print("That movie is already a favority")
        } else {
            
            guard let userUpdated = registerService.oneToManyRelation(oneObject: MovieDetail(dto: movieDetails), to: loginUser) else {return }
            
            isFavorite.toggle()
            updateLoginUser(userUpdated)
            
            print(userUpdated)
            
        }
        
        }
    
    private func setMoviesAlreadyExist(){
        
        guard let userLogged = loginUser as? UserEntity else {return }
        guard let moviesLogged = userLogged.favouriteMovies else {return}
        
        self.userFavouriteMovies = moviesLogged
        
        
    }
    
   private func doesMovieIdExist(in movieSet: NSSet?, movieId: Int) -> Bool {
        guard let movieSet = movieSet else { return false }
        
        for case let movieEntity as MovieEntity in movieSet {

            if movieEntity.id == movieId {
                return true
            }
        }
        
        return false
    }
    
    func updateLoginUser(_ user: AnyObject) {
            self.loginUser = user
        print("on movie detail view update user \(self.loginUser)")
        updateDelegate?.didUpdateLoginUser(self.loginUser)
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
    
    class func buildMovieDetails(movieId: Int, onLoginUser: AnyObject) -> MovieDetailViewController {
        
        let movieDetailController = MovieDetailViewController(movieID: movieId, loginUser: onLoginUser)
        
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


