//
//  NYCHSSChoolCell.swift
//  20200716-JacobHaff-NYCSchools
//
//  Created by Jacob Haff on 7/16/20.
//  Copyright © 2020 Jacob Haff. All rights reserved.
//

import UIKit

class NYCHSSchoolCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var schoolCityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCardViewShadows()
    }
    
    override func layoutSubviews() {
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {	
            var frame = newFrame
            frame.size.height = 150
            super.frame = frame
        }
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

    @IBAction func navigateButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func callButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func detailsButtonPressed(_ sender: UIButton) {
    }
}
