//
//  Picture.swift
//  JournalApp
//
//  Created by Patrick Gao on 1/09/2015.
//  Copyright (c) 2015 Patrick Gao. All rights reserved.
//

import Foundation
import CoreData

class Picture: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var path: String

}
