//
//  MovieEntity+CoreDataProperties.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 20/12/24.
//
//

import Foundation
import CoreData


extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var status: String?
    @NSManaged public var vote_average: Float
    @NSManaged public var release_date: String?
    @NSManaged public var overview: String?
    @NSManaged public var poster_path: String?
    @NSManaged public var id: Int64
    @NSManaged public var genres: NSSet?

}

// MARK: Generated accessors for genres
extension MovieEntity {

    @objc(addGenresObject:)
    @NSManaged public func addToGenres(_ value: GenresEntity)

    @objc(removeGenresObject:)
    @NSManaged public func removeFromGenres(_ value: GenresEntity)

    @objc(addGenres:)
    @NSManaged public func addToGenres(_ values: NSSet)

    @objc(removeGenres:)
    @NSManaged public func removeFromGenres(_ values: NSSet)

}

extension MovieEntity : Identifiable {

}
