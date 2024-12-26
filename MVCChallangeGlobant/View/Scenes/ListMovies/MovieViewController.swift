//
//  MovieViewController.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 28/11/24.
//

import Foundation
import SwiftUI
import UIKit
import Combine


class MovieViewController: UIViewController {
    
    var page: Int = 1
    var totalResponses: Int = 500
    var loginUser: AnyObject
    let registerService: enterAppDelegate
    var language: String
    weak var updateDelegate: MovieDetailUpdateDelegate?
    
    private var viewType: ViewType
        
        enum ViewType {
            case grid
            case content
        }
    
    
    init(movieService: MovieListService = MovieListService(), viewType: ViewType, loginUser: AnyObject, registerService: enterAppDelegate = CoreDataService(), language: String){
       
        self.viewType = viewType
        self.loginUser = loginUser
        self.registerService = registerService
        self.language = language
        super.init(nibName: nil, bundle: nil)
        
        guard let userUsedService = registerService.fetchUser(userToFetch: self.loginUser) else {return }
        
        createMovieView(moviesList: userUsedService.favouriteMovies)
        
        
        
    }
    
    private func createMovieView(moviesList: NSSet?){
        
        HostingControllerBuilder.hostingControllerCreateView(in: self) {
                // Ensure the closure returns a SwiftUI view
                switch self.viewType {
                case .grid:
                    return AnyView( self.createGridView(listOfMovie: moviesList)) // Return the grid view
                case .content:
                    return AnyView(self.createContentView(listOfMovie: moviesList)) // Return the content view
                }
            }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if let navigationController = self.navigationController {
                print("Navigation Controller found: \(navigationController.description)")
                
            } else {
                print("No navigation controller found.")
            }
        
        guard let userLogged = registerService.fetchUser(userToFetch: self.loginUser) as? UserEntity else {return }
        
        guard let updatedUser = registerService.loginUser(email: userLogged.email ?? "", password: userLogged.password ?? "") else {return }
        
        self.createMovieView(moviesList: updatedUser.favouriteMovies)
        
        
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
        
        }
        
    
    private func convertToMovieArray(from movieSet: NSSet?) -> [Movie] {
        guard let movieSet = movieSet else { return [] }
        
        var movieArray: [Movie] = []
        
        for case let movieEntity as MovieEntity in movieSet {
            // Creating a Movie struct from MovieEntity properties
            if let title = movieEntity.title,
               let releaseDate = movieEntity.release_date,
               let posterPath = movieEntity.poster_path {
                let movie = Movie(
                    
                    id: Int(movieEntity.id), // You might want to replace this with a proper id if you have one
                    release_date: releaseDate,
                    title: title,
                    vote_average: movieEntity.vote_average,
                    poster_path: posterPath
                    
                )
                movieArray.append(movie)
            }
        }
        
        return movieArray
    }

}

extension MovieViewController: MovieSelectedDelegate, MovieDetailUpdateDelegate {
    
    func didUpdateLoginUser(_ user: AnyObject) {
        self.loginUser = user
        print("on movie search view update \(loginUser)")
        
    }
    
    func goToMovieDetails(id: Int) {
        
        print("\(id)" + "en go to movie details funcion")
        
        let hostingController = MovieDetailViewController(movieID: id, loginUser: loginUser, language: language)
    
        hostingController.updateDelegate = self
        self.navigationController?.pushViewController(hostingController, animated: true)
    }
    
    
}

extension MovieViewController {
    
    func createGridView(listOfMovie: NSSet?) -> some View {
        
        let movies = convertToMovieArray(from: listOfMovie)
        
            var gridLayoutView =
               GridLayoutView(
                listOfMovies: movies
                    //textLabelInput: TextLabelInput(inputText: <#T##Binding<String>#>, enterText: <#T##String#>)
                )
                        
        gridLayoutView.movieChosenDelegate = self
            
        
        return gridLayoutView
        
    }
    
    
    func createContentView(listOfMovie: NSSet?) -> some View {
        
        let movies = convertToMovieArray(from: listOfMovie)
        
            var contentView =
                ContentView(
                    listOfMovies: movies
                )
        
        contentView.movieChosenDelegate = self
        
        
        return contentView
                
    }
    
}

extension MovieViewController{
    
    class func buildSimpleList(onLoginUser: AnyObject, language: String = "en") -> MovieViewController {
        
        let movieController = MovieViewController(viewType: .content, loginUser: onLoginUser, language: language)
        
        movieController.tabBarItem.image = UIImage(systemName: "star.fill")
        
        return movieController
        
    }
    
    class func buildGridList(onLoginUser: AnyObject, language: String = "en") -> MovieViewController {
        
        let movieController = MovieViewController(viewType: .grid, loginUser: onLoginUser, language: language)
        
        movieController.tabBarItem.image = UIImage(systemName: "star.fill")
//        movieController.view.backgroundColor = UIColor.red
        
        return movieController
        
    }
}





