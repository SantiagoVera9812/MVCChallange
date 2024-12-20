//
//  GenresEntity+CoreDataProperties.swift
//  MVCChallangeGlobant
//
//  Created by Christian Santiago Vera Rojas on 20/12/24.
//
//

import Foundation
import CoreData


extension GenresEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GenresEntity> {
        return NSFetchRequest<GenresEntity>(entityName: "GenresEntity")
    }

    @NSManaged public var name: String?

}

extension GenresEntity : Identifiable {

}
