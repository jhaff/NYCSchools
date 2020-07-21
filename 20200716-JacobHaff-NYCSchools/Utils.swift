//
//  Utils.swift
//  20200716-JacobHaff-NYCSchools
//
//  Created by Jacob Haff on 7/16/20.
//  Copyright © 2020 Jacob Haff. All rights reserved.
//

import Foundation
import CoreLocation


class Utils {
    
    /// This function will fetch the address without coodinates
    ///
    /// - Returns: Stirng, address of the high school
    static func getCompleteAddressWithoutCoordinate(_ schoolAddr: String?) -> String{
        if let schoolAddress = schoolAddr {
            let address = schoolAddress.components(separatedBy: "(")
            return address[0]
        }
        return ""
    }
    
    /// This function will fetch the coodinates for the selected High School location
    ///
    /// - Returns: CLLocationCoordinate2D, coodinate of High School location
    static func getCoodinateForSelectedHighSchool(_ schoolAddr: String?) -> CLLocationCoordinate2D?{
        if let schoolAddress = schoolAddr{
            let coordinateString = schoolAddress.slice(from: "(", to: ")")
            let coordinates = coordinateString?.components(separatedBy: ",")
            if let coordinateArray = coordinates{
                let latitude = (coordinateArray[0] as NSString).doubleValue
                let longitude = (coordinateArray[1] as NSString).doubleValue
                return CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
            }
        }
        return nil
    }
    
    /**
     Pass the JSON and configure to the model type
     
     - Parameter highSchoolsData: Data of Array composed with Dictionary
     - Returns: Array of NYCHighSchool
     */
    static func fetchNYCHsWithJsonData(_ highSchoolsData: Any) -> [NYCHighSchool]? {
        guard let highSchoolsDictionaryArray = highSchoolsData as? [[String: Any]] else {
            return nil
        }
        var highSchoolModelArray = [NYCHighSchool]()
        for highSchoolDictionary in highSchoolsDictionaryArray{
            if let highSchoolModels = Utils.nycHighSchoolWithJSON(highSchoolDictionary){
                highSchoolModelArray.append(highSchoolModels)
            }
        }
        return highSchoolModelArray
    }
    
    /**
     Used to parse JSON payload and assign variables to the NYCHighSchool object
     
     - Parameter json: Dictionany with details of one school
     - Returns: ONE High School Model
     */
    static func nycHighSchoolWithJSON(_ json: [String: Any]) -> NYCHighSchool? {
        if !json.isEmpty {
            let nycHighSchool = NYCHighSchool()
            
            if let idObject = json["dbn"] as? String {
                nycHighSchool.dbn = idObject
            }
            if let schoolNameOnject = json["school_name"] as? String {
                nycHighSchool.schoolName = schoolNameOnject
            }
            if let overviewParagraphObject = json["overview_paragraph"] as? String {
                nycHighSchool.overviewParagraph = overviewParagraphObject
            }
            if let schoolAddressObject = json["location"] as? String {
                nycHighSchool.location = schoolAddressObject
            }
            if let schoolPhoneNumberObject = json["phone_number"] as? String {
                nycHighSchool.phoneNumber = schoolPhoneNumberObject
            }
            if let websiteObject = json["website"] as? String {
                nycHighSchool.website = websiteObject
            }
            
            return nycHighSchool
        }
        return nil
    }
}
