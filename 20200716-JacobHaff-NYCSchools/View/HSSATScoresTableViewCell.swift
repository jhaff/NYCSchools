//
//  HSSATScoresTableViewCell.swift
//  20200716-JacobHaff-NYCSchools
//
//  Created by Jacob Haff on 7/20/20.
//  Copyright © 2020 Jacob Haff. All rights reserved.
//

import UIKit

class HSSATScoresTableViewCell: UITableViewCell {

    @IBOutlet weak var readingScoreLabel: UILabel!
    @IBOutlet weak var writingScoreLabel: UILabel!
    @IBOutlet weak var mathScoreLabel: UILabel!
    
    @IBOutlet weak var readingScoreBar: UIView!
    @IBOutlet weak var writingScoreBar: UIView!
    @IBOutlet weak var mathScoreBar: UIView!
    
    func configure(with HSWithSatScore: NYCHighSchool) {
        
        //For some high school, there is no information of the average SAT score, display the static mesaage to the customers
        readingScoreLabel.text = (HSWithSatScore.satCriticalReadingAvgScore != nil) ?  (DetailConstants.averageSATReadingScore + HSWithSatScore.satCriticalReadingAvgScore!) : DetailConstants.noSATScoreInfomationText
        
        // Sets the Math Average Score
        mathScoreLabel.isHidden = (HSWithSatScore.satMathAvgScore != nil) ? false : true
        mathScoreLabel.text = (HSWithSatScore.satMathAvgScore != nil) ? (DetailConstants.averageSATMathScore + HSWithSatScore.satMathAvgScore!) : nil
        
        // Sets the Writing Average Score
        writingScoreLabel.isHidden =  (HSWithSatScore.satWritinAvgScore != nil) ? false : true
        writingScoreLabel.text = (HSWithSatScore.satWritinAvgScore != nil) ? (DetailConstants.averageSATWritingScore + HSWithSatScore.satWritinAvgScore!) : nil
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
