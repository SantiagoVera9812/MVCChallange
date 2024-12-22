//
//  SearchMovieService.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 18/12/24.
//

import Foundation
import CoreData

class LocalService{
    
    var delegate: enterAppDelegate?
    
}

protocol enterAppDelegate: AnyObject {
    
    func registerUser(email: String, password: String)
    func oneToManyRelation(oneObject: AnyObject, to: AnyObject)
    func loginUser(email: String, password: String) -> AnyObject?
    func modifyUser(email: String, password: String)
    func fetchUser(userToFetch: AnyObject) -> AnyObject?
}

class CoreDataService: enterAppDelegate {
    
    var movieId: Int64
    
    init(movieid: Int64 = 0){
        self.movieId = movieid
    }
    
    
    func fetchUser(userToFetch: AnyObject) -> AnyObject? {
        
        guard let userLogged = userToFetch as? UserEntity else {return nil }
        return userLogged
    }
    
    
    func oneToManyRelation(oneObject movie: AnyObject, to user: AnyObject) {
        
        print("adding a movie to a user")
        
        guard let userLogged = user as? UserEntity else {return }
        print(userLogged)
        
        guard let movieToAdd = movie as? MovieDetail else {return }
        
        let context = CoreDataStack.shared.context
        
        let newMovie = MovieEntity(context: context)
            newMovie.title = movieToAdd.title
            newMovie.status = movieToAdd.status
            newMovie.vote_average = movieToAdd.vote_average
            newMovie.release_date = movieToAdd.release_date
            newMovie.overview = movieToAdd.overview
            newMovie.poster_path = movieToAdd.poster_path
            newMovie.id = movieId
        
        for genre in movieToAdd.genres {
                // Create or fetch GenreEntity if needed, and add to movie's genres
                let genreEntity = GenresEntity(context: context)
                genreEntity.name = genre.name
                newMovie.addToGenres(genreEntity) // Add genre to movie's genres
            }
        
        userLogged.addToFavouriteMovies(newMovie)
            
            // Save the context
            do {
                try context.save()
                print("Movie added to user's favourites successfully!")
            } catch {
                print("Failed to save context after adding movie: \(error)")
            }
        
    }
    
    
    func modifyUser(email: String, password: String) {
        print("on modify user")
    }
    
    
    func registerUser(email: String, password: String) {
        
        let context = CoreDataStack.shared.context

            // Create a new User entity
            let newUser = UserEntity(context: context) // Assuming UserEntity is your Core Data entity
            newUser.email = email
            newUser.password = password
            newUser.favouriteMovies = NSSet() // Start with an empty set for favouriteMovies

            // Save the context
            do {
                try context.save()
                print("User registered successfully!")
            } catch {
                print("Failed to save user: \(error)")
            }

    }
    
    func loginUser(email: String, password: String) -> AnyObject? {
        
        let context = CoreDataStack.shared.context
                
                //crear request
                let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
                
                //filtro
                fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", email, password)
                
                do {
                
                    let users = try context.fetch(fetchRequest)
                    
                    if let user = users.first {
                        print("Login successful for user: \(user.email ?? "")")
                        return user
                        
                    } else {
                        print("No user found with provided email and password.")
                        return nil
                    }
                } catch {
                    print("Failed to fetch users: \(error)")
                    return nil
                }
    }
    
}

class CoreDataStack {
    static let shared = CoreDataStack() // Singleton instance
    
    // Persistent container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataModel") // Replace with your Core Data model name
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // Managed object context
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
