//
//  Entry.swift
//  JournalApp
//
//  Created by Patrick Gao on 1/09/2015.
//  Copyright (c) 2015 Patrick Gao. All rights reserved.
//

import Foundation
import CoreData

class Entry: NSManagedObject {

    @NSManaged var body: String
    @NSManaged var date: NSDate
    @NSManaged var latitude: NSNumber
    @NSManaged var longtitude: NSNumber
    @NSManaged var title: String
    @NSManaged var pictures: NSSet

}
