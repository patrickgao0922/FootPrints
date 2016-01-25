//
//  CustomAnnotation.swift
//  JournalApp
//
//  Created by Patrick Gao on 2/09/2015.
//  Copyright (c) 2015 Patrick Gao. All rights reserved.
//

import UIKit
import MapKit

class CustomAnnotation:NSObject, MKAnnotation {
    var coordinate:CLLocationCoordinate2D
    var entry:Entry
    var title:String?
    init(entry:Entry) {
        coordinate = CLLocationCoordinate2D();
        self.entry = entry
        title = entry.title
    }
}
