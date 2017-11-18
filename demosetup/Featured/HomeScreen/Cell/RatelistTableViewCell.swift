//
//  RatelistTableViewCell.swift
//  demosetup
//
//  Created by Nikunj on 09/10/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit

import FloatRatingView

class RatelistTableViewCell: UITableViewCell {

    
    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var lbltext: UILabel!
    
    @IBOutlet weak var ratingView: FloatRatingView!
    
    @IBOutlet weak var btnSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
