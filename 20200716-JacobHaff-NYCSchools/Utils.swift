//
//  Utils.swift
//  20200716-JacobHaff-NYCSchools
//
//  Created by Jacob Haff on 7/16/20.
//  Copyright © 2020 Jacob Haff. All rights reserved.
//

import CoreLocation
import Foundation

class Utils {
    /**
      Fetch the address without coodinates

      - Parameter schoolAddr: unprocessed location string straight from the json
      - Returns: String, address of the high school
     */
    static func getCompleteAddressWithoutCoordinate(_ schoolAddr: String?) -> String {
        if let schoolAddress = schoolAddr {
            let address = schoolAddress.components(separatedBy: "(")
            return address[0]
        }
        return ""
    }

    /** This function will fetch the coodinates for the selected High School location

      - Parameter schoolAddr: unprocessed location string straight from the json
      - Returns: CLLocationCoordinate2D, coodinate of High School location
     */
    static func getCoodinateForSelectedHighSchool(_ schoolAddr: String?) -> CLLocationCoordinate2D? {
        if let schoolAddress = schoolAddr {
            let coordinateString = schoolAddress.slice(from: "(", to: ")")
            let coordinates = coordinateString?.components(separatedBy: ",")
            if let coordinateArray = coordinates {
                let latitude = (coordinateArray[0] as NSString).doubleValue
                let longitude = (coordinateArray[1] as NSString).doubleValue
                return CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
            }
        }
        return nil
    }
}
