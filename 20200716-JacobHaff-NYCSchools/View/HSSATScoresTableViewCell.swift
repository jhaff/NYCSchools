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
    
    func configure(with hsWithSatScore: NYCHighSchool) {
        
        //For some high school, there is no information of the average SAT score, display the static mesaage to the customers
        
        if (hsWithSatScore.satCriticalReadingAvgScore) != nil {
            readingScoreLabel.text = DetailConstants.averageSATReadingScore + String(hsWithSatScore.satCriticalReadingAvgScore!)
//            readingScoreBar.frame.size.width = readingScoreBar.frame.size.width * CGFloat(calculateSATPercentage(satScore: Int(hsWithSatScore.satCriticalReadingAvgScore!)!))
            
            var frame: CGRect = readingScoreBar.frame
            
            frame.size.width = readingScoreBar.frame.size.width * CGFloat(calculateSATPercentage(satScore: Int(hsWithSatScore.satCriticalReadingAvgScore!)!))
            
            readingScoreBar.frame = frame
            
            readingScoreBar.setNeedsDisplay()
        }
        
        if (hsWithSatScore.satMathAvgScore) != nil {
            mathScoreLabel.text = DetailConstants.averageSATMathScore + String(hsWithSatScore.satMathAvgScore!)
        }
        
        if (hsWithSatScore.satWritingAvgScore) != nil {
            writingScoreLabel.text = DetailConstants.averageSATWritingScore + String(hsWithSatScore.satWritingAvgScore!)
        }
        
    }
    
    func calculateSATPercentage(satScore: Int) -> Float {
        return Float(satScore) / 800.00
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
