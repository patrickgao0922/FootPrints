//
//  Entry+CoreDataProperties.swift
//  FootPrints
//
//  Created by Patrick Gao on 27/01/2016.
//  Copyright © 2016 Patrick Gao. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Entry {

    @NSManaged var title: String?
    @NSManaged var body: String?
    @NSManaged var longtitude: NSNumber?
    @NSManaged var latitude: NSNumber?
    @NSManaged var date: NSDate?
    @NSManaged var pictures: NSSet?

}
