//
//  K.swift
//  20200716-JacobHaff-NYCSchools
//
//  Created by Jacob Haff on 7/16/20.
//  Copyright © 2020 Jacob Haff. All rights reserved.
//

import Foundation

struct Constants {
    static let highSchoolsURL = "https://data.cityofnewyork.us/resource/97mf-9njv.json"
    static let schoolDetailsUrl = "https://data.cityofnewyork.us/resource/734v-jeq5.json"

    static let hsCellIdentifier = "SchoolCell"
    static let HSDetailsSegue = "HSDetailsSegue"

}

struct DetailConstants {
    struct Cells {
        static let schoolWithSATScoreCellIdentifier =  "HSSATScoresTableViewCell"
        static let schoolOverviewCellIdentifier = "HSOverviewTableViewCell"
        static let schoolWithAddressCellIdentifier = "HSMapTableViewCell"
        static let schoolWithContactCellIdentifier = "HSContactTableViewCell"
    }

    
    static let noSATScoreInfomationText = "There is no SAT score information for this high school"
    static let averageSATReadingScore = "Critical Reading: "
    static let averageSATMathScore = "Math: "
    static let averageSATWritingScore = "Writing: "
}
