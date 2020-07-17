//
//  Utils.swift
//  20200716-JacobHaff-NYCSchools
//
//  Created by Jacob Haff on 7/16/20.
//  Copyright © 2020 Jacob Haff. All rights reserved.
//

import Foundation


class Utils {
    
    /**
     Pass the JSON and configure to the model type
     
     - Parameter highSchoolsData: Array of dictionaries containing HS Data
     
     - Returns: Array of NYCHighSchools
     */
    static func highSchoolsJSONDataToModelArray(_ highSchoolsData: Any) -> [NYCHighSchool]? {
        guard let highSchoolsDictionaryArray = highSchoolsData as? [[String: Any]] else{
            return nil
        }
        
        var NYCHighSchoolArray = [NYCHighSchool]()
        
        for highSchoolDictionary in highSchoolsDictionaryArray {
            if let highSchoolModel = Utils.nycHighSchoolWithJSON(highSchoolDictionary) {
                NYCHighSchoolArray.append(highSchoolModel)
            }
        }
        
        return NYCHighSchoolArray
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
                nycHighSchool.id = idObject
            }
            if let schoolNameOnject = json["school_name"] as? String {
                nycHighSchool.name = schoolNameOnject
            }
            if let overviewParagraphObject = json["overview_paragraph"] as? String {
                nycHighSchool.overview = overviewParagraphObject
            }
            if let schoolAddressObject = json["location"] as? String {
                nycHighSchool.address = schoolAddressObject
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
