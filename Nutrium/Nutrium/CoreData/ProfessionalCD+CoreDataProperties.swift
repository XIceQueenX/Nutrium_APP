//
//  ProfessionalCD+CoreDataProperties.swift
//  Nutrium
//
//  Created by Gloria Martins on 20/03/2025.
//
//

import Foundation
import CoreData


extension ProfessionalCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProfessionalCD> {
        return NSFetchRequest<ProfessionalCD>(entityName: "ProfessionalCD")
    }

    @NSManaged public var about_me: String?
    @NSManaged public var expertise: NSArray?
    @NSManaged public var id_professional: Int16
    @NSManaged public var languages: NSArray?
    @NSManaged public var name: String?
    @NSManaged public var profile_picture_url: Data?
    @NSManaged public var rating: Int16
    @NSManaged public var rating_count: Int16

}

extension ProfessionalCD : Identifiable {

}
