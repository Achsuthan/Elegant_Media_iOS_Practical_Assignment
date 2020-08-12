//
//  HotelLocationViewController.swift
//  ElegantMediaiOSPracticalAssignment
//
//  Created by Achsuthan Mahendran on 8/12/20.
//  Copyright © 2020 Achsuthan Mahendran. All rights reserved.
//

import UIKit
import MapKit

class HotelLocationViewController: UIViewController {
    
    //MARK: - MKMap
    let hotelLocationMap: MKMapView = {
        let view  = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let locationManager = CLLocationManager()
    
    var singleHotelDetails: HotelModel  = HotelModel(id: 0, description: "", title: "", latitude: "", image: Image(small: "", medium: "", large: ""), postcode: "", address: "", phoneNumber: "", longitude: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNav()
        self.setUp()
    }
    
    //MARK: - Setup the navigation bar
    private func setUpNav(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = APP_COLOR
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationItem.title = "Map"
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        backButton.addTarget(self, action: #selector(self.btBack(_:)), for: .touchUpInside)
        let backbuttonImage = #imageLiteral(resourceName: "back")
        let backBlackButton = backbuttonImage.withRenderingMode(.alwaysTemplate)
        backButton.setBackgroundImage(backBlackButton, for: .normal)
        backButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    //MARK: - setup all the UIs
    private func setUp(){
        self.view.backgroundColor = .white
        self.view.addSubview(self.hotelLocationMap)
        self.hotelLocationMap.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.hotelLocationMap.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.hotelLocationMap.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.hotelLocationMap.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        if CLLocationManager.locationServicesEnabled() {
            self.checkLocationAuthorization()
        } else {
            // Do something to let users know why they need to turn it on.
            //Need to connect with the user's app setting page
        }
    }
    
    //MARK: - Common function to validte the user enable disable for location service
    private func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            hotelLocationMap.showsUserLocation = true
            self.pinLocation()
        case .denied: // Show alert telling users how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            hotelLocationMap.showsUserLocation = true
            self.pinLocation()
        case .restricted: // Show an alert letting them know what’s up
            break
        case .authorizedAlways:
            self.pinLocation()
            break
        default:
            break
        }
    }
    
    //MARK: - pin the hotel location
    private func pinLocation(){
        let annotation = MKPointAnnotation()
        annotation.title = self.singleHotelDetails.title
        annotation.subtitle = self.singleHotelDetails.address
        annotation.coordinate = CLLocationCoordinate2D(latitude:
            Double(self.singleHotelDetails.latitude) ?? 0.00, longitude: Double(self.singleHotelDetails.longitude) ?? 0.00)
        hotelLocationMap.addAnnotation(annotation)
        let diameter = 1 * 2000
        let location = CLLocationCoordinate2D(latitude: Double(self.singleHotelDetails.latitude) ?? 0.00,
                                              longitude: Double(self.singleHotelDetails.longitude) ?? 0.00)
        
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, latitudinalMeters: CLLocationDistance(diameter), longitudinalMeters: CLLocationDistance(diameter))
        self.hotelLocationMap.setRegion(region, animated: false)
        
    }
    
    //MARK: - Back button event
    @IBAction func btBack(_ : Any){
        self.navigationController?.popViewController(animated: true)
    }
    
}
