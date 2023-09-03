//
//  Favourite+CoreDataProperties.swift
//  UserList
//
//  Created by Hoang Linh Nguyen on 5/9/2023.
//
//

import UIKit
import CoreData

extension Favourite {
    @nonobjc class func fetchRequest() -> NSFetchRequest<Favourite> {
        return NSFetchRequest<Favourite>(entityName: "Favourite")
    }
    
    @NSManaged var image: String?
    @NSManaged var link: String?
    @NSManaged var name: String?
}
