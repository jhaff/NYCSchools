//
//  HSContactTableViewCell.swift
//  20200716-JacobHaff-NYCSchools
//
//  Created by Jacob Haff on 7/19/20.
//  Copyright © 2020 Jacob Haff. All rights reserved.
//

import UIKit

class HSContactTableViewCell: UITableViewCell {

    @IBOutlet weak var schoolAddressLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with hsWithSatScore: NYCHighSchool) {
            
        schoolAddressLabel.text = "Address: " + Utils.getCompleteAddressWithoutCoordinate(hsWithSatScore.location)
              
        phoneNumberLabel.text = (hsWithSatScore.phoneNumber != nil) ? "Tel:  " + hsWithSatScore.phoneNumber! : ""
               
        websiteLabel.text = hsWithSatScore.website

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
