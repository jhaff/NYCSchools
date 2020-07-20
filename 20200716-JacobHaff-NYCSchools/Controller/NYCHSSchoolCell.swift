//
//  NYCHSSChoolCell.swift
//  20200716-JacobHaff-NYCSchools
//
//  Created by Jacob Haff on 7/16/20.
//  Copyright © 2020 Jacob Haff. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class NYCHSSchoolCell: UITableViewCell {
    
    var school = NYCHighSchool()

    @IBOutlet weak var yo: UIView!
    //    @IBOutlet weak var cardView: UIView!
//    @IBOutlet weak var schoolNameLabel: UILabel!
//    @IBOutlet weak var schoolCityLabel: UILabel!
    
    override func layoutMarginsDidChange() {
        super.layoutMarginsDidChange()
       
    }
    
    override func layoutSubviews() {
            self.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
       }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        schoolNameLabel.text = school.name
//        schoolCityLabel.text = school.address
        
    
//        setupCardViewShadows()
    }

//    func setupCardViewShadows() {
//        let view = cardView
//        view?.layer.cornerRadius = 15.0
//        view?.layer.shadowColor = UIColor.black.cgColor
//        view?.layer.shadowOffset = CGSize(width: 0, height: 2)
//        view?.layer.shadowOpacity = 0.8
//        view?.layer.shadowRadius = 3
//        view?.layer.masksToBounds = false
//    }

    @IBAction func navigateButtonPressed(_ sender: UIButton) {
        let schoolAddress = school.address
        
        
        
        if let highSchoolCoordinate = getCoodinateForSelectedHighSchool(schoolAddress){
            let coordinate = CLLocationCoordinate2DMake(highSchoolCoordinate.latitude, highSchoolCoordinate.longitude)
            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
            mapItem.name = "\(school.name!)"
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
        }
    }
    
    @IBAction func callButtonPressed(_ sender: UIButton) {
//        callNumber(sender)
    }
    
    @IBAction func detailsButtonPressed(_ sender: UIButton) {
      
    }
    
    private func getCoodinateForSelectedHighSchool(_ schoolAddr: String?) -> CLLocationCoordinate2D?{
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
    
//   func callNumber(_ sender: UIButton){
//
//    let schoolPhoneNumber = school.phoneNumber
//
//        if let url = URL(string: "tel://\(String(describing: schoolPhoneNumber))"), UIApplication.shared.canOpenURL(url) {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        }else{
//            let alertView = UIAlertController(title: "Error!", message: "Please run on a real device to call \(schoolPhoneNumber!)", preferredStyle: .alert)
//
//            let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
//
//            alertView.addAction(okayAction)
//
//            present(alertView, animated: true, completion: nil)
//        }
//    }
}
