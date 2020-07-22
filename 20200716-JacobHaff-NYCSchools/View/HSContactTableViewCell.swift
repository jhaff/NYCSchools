//
//  HSContactTableViewCell.swift
//  20200716-JacobHaff-NYCSchools
//
//  Created by Jacob Haff on 7/19/20.
//  Copyright © 2020 Jacob Haff. All rights reserved.
//

import UIKit

class HSContactTableViewCell: UITableViewCell {
    @IBOutlet var schoolAddressLabel: UILabel!
    @IBOutlet var phoneNumberLabel: UILabel!
    @IBOutlet var websiteLabel: UILabel!

    func configure(with hsWithSatScore: NYCHighSchool) {
        schoolAddressLabel.text = "Address: " + Utils.getCompleteAddressWithoutCoordinate(hsWithSatScore.location)

        phoneNumberLabel.text = (hsWithSatScore.phoneNumber != nil) ? "Tel:  " + hsWithSatScore.phoneNumber! : ""

        websiteLabel.text = hsWithSatScore.website
    }
}
