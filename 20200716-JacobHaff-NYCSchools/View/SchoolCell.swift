//
//  SchoolCell.swift
//  20200716-JacobHaff-NYCSchools
//
//  Created by Jacob Haff on 7/19/20.
//  Copyright © 2020 Jacob Haff. All rights reserved.
//

import UIKit

class SchoolCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var schoolCityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupCardViewShadows()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCardViewShadows() {
        let view = cardView
        view?.layer.cornerRadius = 15.0
        view?.layer.shadowColor = UIColor.black.cgColor
        view?.layer.shadowOffset = CGSize(width: 0, height: 2)
        view?.layer.shadowOpacity = 0.8
        view?.layer.shadowRadius = 3
        view?.layer.masksToBounds = false
    }
    
}
