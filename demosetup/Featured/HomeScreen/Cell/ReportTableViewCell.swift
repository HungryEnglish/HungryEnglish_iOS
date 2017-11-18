//
//  ReportTableViewCell.swift
//  demosetup
//
//  Created by Nikunj on 05/10/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit

class ReportTableViewCell: UITableViewCell {

    
    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var lblteacher: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
