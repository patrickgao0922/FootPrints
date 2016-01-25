//
//  JournalMapTableViewCell.swift
//  JournalApp
//
//  Created by Patrick Gao on 31/08/2015.
//  Copyright (c) 2015 Patrick Gao. All rights reserved.
//

import UIKit
import MapKit

class JournalMapTableViewCell: UITableViewCell,MKMapViewDelegate {
    @IBOutlet weak var journalMap: MKMapView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
