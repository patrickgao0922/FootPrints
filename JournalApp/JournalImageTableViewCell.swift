//
//  JournalImageTableViewCell.swift
//  JournalApp
//
//  Created by Patrick Gao on 1/09/2015.
//  Copyright (c) 2015 Patrick Gao. All rights reserved.
//

import UIKit

class JournalImageTableViewCell: UITableViewCell {
    @IBOutlet weak var journalImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
