//
//  HSNameTableViewCell.swift
//  20200716-JacobHaff-NYCSchools
//
//  Created by Jacob Haff on 7/19/20.
//  Copyright © 2020 Jacob Haff. All rights reserved.
//

import UIKit

class HSNameTableViewCell: UITableViewCell {
    @IBOutlet var schoolNameLabel: UILabel!

    func configure(with hsWithSatScore: NYCHighSchool) {
        schoolNameLabel.text = hsWithSatScore.schoolName
    }
}
