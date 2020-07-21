//
//  File.swift
//  20200716-JacobHaff-NYCSchools
//
//  Created by Jacob Haff on 7/16/20.
//  Copyright © 2020 Jacob Haff. All rights reserved.
//

import Foundation

class NYCHighSchool: Codable {

    var dbn: String?
    var schoolName: String?
    var overviewParagraph: String?
    var satCriticalReadingAvgScore: String?
    var satMathAvgScore: String?
    var satWritingAvgScore: String?
    var location: String?
    var neighborhood: String?
    var borough:  String?
    var phoneNumber: String?
    var website:String?
        
    func getCombinedSATScoreString() -> String {
        if ((satCriticalReadingAvgScore != nil) && (satWritingAvgScore != nil) && (satMathAvgScore != nil)) {
            let satReadingScoreInt = Int(satCriticalReadingAvgScore!)
            let satMathScoreInt = Int(satMathAvgScore!)
            let satWritingScoreInt = Int(satWritingAvgScore!)
            
            let combinedScore = satReadingScoreInt! + satMathScoreInt! + satWritingScoreInt!
            
            return "SAT: " + String(combinedScore)
        } else {
            return "N/A"
        }
    }
    
}
