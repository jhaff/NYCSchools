//
//  HSSATScoresTableViewCell.swift
//  20200716-JacobHaff-NYCSchools
//
//  Created by Jacob Haff on 7/20/20.
//  Copyright © 2020 Jacob Haff. All rights reserved.
//

import UIKit

class HSSATScoresTableViewCell: UITableViewCell {
    @IBOutlet var readingScoreLabel: UILabel!
    @IBOutlet var writingScoreLabel: UILabel!
    @IBOutlet var mathScoreLabel: UILabel!

    func configure(with hsWithSatScore: NYCHighSchool) {
        // For some high schools, there is no information about SAT scores. Display a default message in that case. 

        if hsWithSatScore.satCriticalReadingAvgScore != nil {
            readingScoreLabel.text = DetailConstants.averageSATReadingScore + String(hsWithSatScore.satCriticalReadingAvgScore!)
        } else {
            readingScoreLabel.text = DetailConstants.noSATScoreInfomationText
        }

        if hsWithSatScore.satMathAvgScore != nil {
            mathScoreLabel.text = DetailConstants.averageSATMathScore + String(hsWithSatScore.satMathAvgScore!)
        } else {
            mathScoreLabel.text = ""
        }

        if hsWithSatScore.satWritingAvgScore != nil {
            writingScoreLabel.text = DetailConstants.averageSATWritingScore + String(hsWithSatScore.satWritingAvgScore!)
        } else {
            writingScoreLabel.text = ""
        }
    }

    func calculateSATPercentage(satScore: Int) -> Float {
        return Float(satScore) / 800.00
    }
}
