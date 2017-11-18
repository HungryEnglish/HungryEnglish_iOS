//
//  StudentListTableViewCell.swift
//  demosetup
//
//  Created by Nikunj on 17/09/17.
//  Copyright © 2017 Peerbits. All rights reserved.
//

import UIKit

class StudentListTableViewCell: UITableViewCell {

    // MARK: - OUTLETS -
    
    @IBOutlet weak var viewmain: UIView!
    
    @IBOutlet weak var viewimg: UIView!
    
    
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var lblemail: UILabel!
    
    @IBOutlet weak var lblmobileno: UILabel!
    
    @IBOutlet weak var lblavailability: UILabel!
    
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBOutlet weak var btnDelete: UIButton!
    
    @IBOutlet weak var viewButton: UIView!
    
    @IBOutlet weak var btnAccept: UIButton!
    
    @IBOutlet weak var imgprofile: UIImageView!
    
   
    @IBOutlet weak var lblskills: UILabel!
    
    @IBOutlet weak var btnViewteacher: UIButton!
    
    @IBOutlet weak var lblnearestrailwaystation: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
