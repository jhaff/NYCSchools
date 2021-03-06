//
//  HSMapTableViewCell.swift
//  20200716-JacobHaff-NYCSchools
//
//  Created by Jacob Haff on 7/19/20.
//  Copyright © 2020 Jacob Haff. All rights reserved.
//

import CoreLocation
import MapKit
import UIKit

class HSMapTableViewCell: UITableViewCell {
    @IBOutlet var mapView: MKMapView!

    func addHSAnnotaionWithCoordinates(_ hsCoordinates: CLLocationCoordinate2D) {
        let highSchoolAnnotation = MKPointAnnotation()
        highSchoolAnnotation.coordinate = hsCoordinates
        mapView.addAnnotation(highSchoolAnnotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: highSchoolAnnotation.coordinate, span: span)
        let adjustRegion = mapView.regionThatFits(region)
        mapView.setRegion(adjustRegion, animated: true)
    }
}
