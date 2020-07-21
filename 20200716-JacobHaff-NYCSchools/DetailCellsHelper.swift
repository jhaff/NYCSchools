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
    static func tableViewCellWithSATScore(_ tableView: UITableView, hsWithSatScore: NYCHighSchool) -> UITableViewCell {
        let schoolWithSATScoresCell = tableView.dequeueReusableCell(withIdentifier: DetailConstants.Cells.schoolWithSATScoreCellIdentifier) as! HSSATScoresTableViewCell
                
        schoolWithSATScoresCell.configure(with: hsWithSatScore)
        
        return schoolWithSATScoresCell
    }
    
    /**
    This function get the selected high school's overview
    
    - Returns: UITableViewCell
     */
    static func tableViewCellWithOverView(_ tableView: UITableView, hsWithSatScore: NYCHighSchool) -> UITableViewCell {
        let schoolWithOverviewCell = tableView.dequeueReusableCell(withIdentifier: DetailConstants.Cells.schoolOverviewCellIdentifier) as! HSOverviewTableViewCell
        
        schoolWithOverviewCell.overviewContentLabel.text = hsWithSatScore.overviewParagraph
        
        return schoolWithOverviewCell
    }
    
    /**
    This function get the high school contact information with address, tel and website.

    - Returns: UITableViewCell
     */
    static func tableViewCellWithContactInfo(_ tableView: UITableView, hsWithSatScore: NYCHighSchool) -> UITableViewCell {
        let schoolWithContactCell = tableView.dequeueReusableCell(withIdentifier: DetailConstants.Cells.schoolContactCellIdentifier) as! HSContactTableViewCell
        
        schoolWithContactCell.schoolAddressLabel.text = "Address: " + Utils.getCompleteAddressWithoutCoordinate(hsWithSatScore.location)
        schoolWithContactCell.phoneNumberLabel.text = (hsWithSatScore.phoneNumber != nil) ? "Tel:  " + hsWithSatScore.phoneNumber! : ""
        schoolWithContactCell.websiteLabel.text = hsWithSatScore.website
        
        return schoolWithContactCell
    }
    
   /**
    This function get the High School's location with annotaion on the map

     - Returns: UITableViewCell
     */
    static func tableViewCellWithAddress(_ tableView: UITableView, hsWithSatScore: NYCHighSchool) -> UITableViewCell {
        let schoolWithAddressCell = tableView.dequeueReusableCell(withIdentifier: DetailConstants.Cells.schoolWithMapCellIdentifier) as! HSMapTableViewCell
        
//        if let highSchoolCoordinate = Utils.getCoodinateForSelectedHighSchool(hsWithSatScore.address){
//            schoolWithAddressCell.addHSAnnotaionWithCoordinates(highSchoolCoordinate)
//        }
        
        return schoolWithAddressCell
    }
}
