//
//  UserEntity+CoreDataProperties.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 20/12/24.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var favouriteMovies: NSSet?

}

// MARK: Generated accessors for favouriteMovies
extension UserEntity {

    @objc(addFavouriteMoviesObject:)
    @NSManaged public func addToFavouriteMovies(_ value: MovieEntity)

    @objc(removeFavouriteMoviesObject:)
    @NSManaged public func removeFromFavouriteMovies(_ value: MovieEntity)

    @objc(addFavouriteMovies:)
    @NSManaged public func addToFavouriteMovies(_ values: NSSet)

    @objc(removeFavouriteMovies:)
    @NSManaged public func removeFromFavouriteMovies(_ values: NSSet)

}

extension UserEntity : Identifiable {

}
