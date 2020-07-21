//
//  DetailCellsHelper.swift
//  20200716-JacobHaff-NYCSchools
//
//  Created by Jacob Haff on 7/20/20.
//  Copyright © 2020 Jacob Haff. All rights reserved.
//

import Foundation

import Foundation
import UIKit

class DetailCellsHelper {
    /**
    This function gets the selected High School name's  average sat scores
    
     - Returns: UITableViewCell
     */
    static func tableViewCellWithSATScore(_ tableView: UITableView, HSWithSatScore: NYCHighSchool) -> UITableViewCell {
        let schoolWithSATScoresCell = tableView.dequeueReusableCell(withIdentifier: DetailConstants.Cells.schoolWithSATScoreCellIdentifier) as! HSSATScoresTableViewCell
                
        schoolWithSATScoresCell.configure(with: HSWithSatScore)
//
//        //For some high school, there is no information of the average SAT score, display the static mesaage to the customers
//        schoolWithSATScoresCell.readingScoreLabel.text = (HSWithSatScore.satCriticalReadingAvgScore != nil) ?  (DetailConstants.averageSATReadingScore + HSWithSatScore.satCriticalReadingAvgScore!) : DetailConstants.noSATScoreInfomationText
//
//        // Sets the Math Average Score
//        schoolWithSATScoresCell.mathScoreLabel.isHidden = (HSWithSatScore.satMathAvgScore != nil) ? false : true
//        schoolWithSATScoresCell.mathScoreLabel.text = (HSWithSatScore.satMathAvgScore != nil) ? (DetailConstants.averageSATMathScore + HSWithSatScore.satMathAvgScore!) : nil
//
//        // Sets the Writing Average Score
//        schoolWithSATScoresCell.writingScoreLabel.isHidden =  (HSWithSatScore.satWritinAvgScore != nil) ? false : true
//        schoolWithSATScoresCell.writingScoreLabel.text = (HSWithSatScore.satWritinAvgScore != nil) ? (DetailConstants.averageSATWritingScore + HSWithSatScore.satWritinAvgScore!) : nil
        
        return schoolWithSATScoresCell
    }
    
    /**
    This function get the selected high school's overview
    
    - Returns: UITableViewCell
     */
    static func tableViewCellWithOverView(_ tableView: UITableView, HSWithSatScore: NYCHighSchool) -> UITableViewCell {
        let schoolWithOverviewCell = tableView.dequeueReusableCell(withIdentifier: DetailConstants.Cells.schoolOverviewCellIdentifier) as! HSOverviewTableViewCell
        
        schoolWithOverviewCell.overviewContentLabel.text = HSWithSatScore.overview
        
        return schoolWithOverviewCell
    }
    
    
    /**
    This function get the high school contact information with address, tel and website.

    - Returns: UITableViewCell
     */
    static func tableViewCellWithContactInfo(_ tableView: UITableView, HSWithSatScore: NYCHighSchool) -> UITableViewCell {
        let schoolWithContactCell = tableView.dequeueReusableCell(withIdentifier: DetailConstants.Cells.schoolWithContactCellIdentifier) as! HSContactTableViewCell
        
        schoolWithContactCell.schoolAddressLabel.text = "Address: " + Utils.getCompleteAddressWithoutCoordinate(HSWithSatScore.address)
        schoolWithContactCell.phoneNumberLabel.text = (HSWithSatScore.phoneNumber != nil) ? "Tel:  " + HSWithSatScore.phoneNumber! : ""
        schoolWithContactCell.websiteLabel.text = HSWithSatScore.website
        
        return schoolWithContactCell
    }
    
   /**
    This function get the High School's location with annotaion on the map

     - Returns: UITableViewCell
     */
    static func tableViewCellWithAddress(_ tableView: UITableView, HSWithSatScore: NYCHighSchool) -> UITableViewCell {
        let schoolWithAddressCell = tableView.dequeueReusableCell(withIdentifier: DetailConstants.Cells.schoolWithAddressCellIdentifier) as! HSContactTableViewCell
        
//        if let highSchoolCoordinate = Utils.getCoodinateForSelectedHighSchool(HSWithSatScore.address){
//            schoolWithAddressCell.addHSAnnotaionWithCoordinates(highSchoolCoordinate)
//        }
        
        return schoolWithAddressCell
    }
}
