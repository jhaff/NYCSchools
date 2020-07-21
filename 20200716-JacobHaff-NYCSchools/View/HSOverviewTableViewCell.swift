//
//  HSOverviewTableViewCell.swift
//  20200716-JacobHaff-NYCSchools
//
//  Created by Jacob Haff on 7/19/20.
//  Copyright © 2020 Jacob Haff. All rights reserved.
//

import UIKit

class HSOverviewTableViewCell: UITableViewCell {

    @IBOutlet weak var overviewContentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with hsWithSatScore: NYCHighSchool) {
        
        overviewContentLabel.text = hsWithSatScore.overviewParagraph
        
    }

}
