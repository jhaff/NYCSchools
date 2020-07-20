//
//  Router.swift
//  20200716-JacobHaff-NYCSchools
//
//  Created by Jacob Haff on 7/19/20.
//  Copyright © 2020 Jacob Haff. All rights reserved.
//

import Foundation

enum Router {
    
    case getSchools
    case getDetails
    
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "data.cityofnewyork.us"
    }
    
    var path: String {
        switch self {
        case .getSchools:
            return "/resource/97mf-9njv.json"
        case .getDetails:
            return "/resource/734v-jeq5.json"
        }
    }
    
    var method: String {
        return "GET"
    }
    
    
}
