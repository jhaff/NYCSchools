//
//  SchoolCell.swift
//  20200716-JacobHaff-NYCSchools
//
//  Created by Jacob Haff on 7/19/20.
//  Copyright © 2020 Jacob Haff. All rights reserved.
//

import CoreLocation
import MapKit
import UIKit

class SchoolCell: UITableViewCell {
    @IBOutlet var cardView: UIView!
    @IBOutlet var scoreView: UIView!

    @IBOutlet var schoolNameLabel: UILabel!
    @IBOutlet var schoolCityLabel: UILabel!
    @IBOutlet var schoolCombinedSATLabel: UILabel!

    var school = NYCHighSchool()

    override func awakeFromNib() {
        super.awakeFromNib()

        setupCardViewShadows()
    }

    func setupCardViewShadows() {
        let view = cardView
        view?.layer.cornerRadius = 15.0
        view?.layer.shadowColor = UIColor.black.cgColor
        view?.layer.shadowOffset = CGSize(width: 0, height: 2)
        view?.layer.shadowOpacity = 0.7
        view?.layer.shadowRadius = 3
        view?.layer.masksToBounds = false

        let view2 = scoreView
        view2?.layer.cornerRadius = 8.0
    }

    @IBAction func navigateButtonPressed(_: UIButton) {
        let schoolAddress = school.location

        if let highSchoolCoordinate = getCoodinateForSelectedHighSchool(schoolAddress) {
            let coordinate = CLLocationCoordinate2DMake(highSchoolCoordinate.latitude, highSchoolCoordinate.longitude)
            let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
            mapItem.name = "\(school.schoolName!)"
            mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
        }
    }

    private func getCoodinateForSelectedHighSchool(_ schoolAddr: String?) -> CLLocationCoordinate2D? {
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

    @IBAction func callButtonPressed(_: Any) {
        let schoolPhoneNumber = school.phoneNumber

        if let url = URL(string: "tel://\(String(describing: schoolPhoneNumber))"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            let alertView = UIAlertController(title: "Error!", message: "Please run on a real device to call \(schoolPhoneNumber!)", preferredStyle: .alert)

            let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)

            alertView.addAction(okayAction)

            // given more time I would google more about this warning and find a better solution. This seems to work well though.
            UIApplication.shared.keyWindow?.rootViewController?.present(alertView, animated: true, completion: nil)
        }
    }
}
