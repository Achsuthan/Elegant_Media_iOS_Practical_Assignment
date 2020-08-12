//
//  HotelDetailsViewController.swift
//  ElegantMediaiOSPracticalAssignment
//
//  Created by Achsuthan Mahendran on 8/12/20.
//  Copyright © 2020 Achsuthan Mahendran. All rights reserved.
//

import UIKit

class HotelDetailsViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: - hotel Image
    let hotelImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    //MARK: - hotel name
    let lblHotelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.text = ""
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - hotel discription
    let lblHotelDiscription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = ""
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNav()
        self.setUp()
    }
    
    var singleHotelDetails: HotelModel  = HotelModel(id: 0, description: "", title: "", latitude: "", image: Image(small: "", medium: "", large: ""), postcode: "", address: "", phoneNumber: "", longitude: ""){
        didSet{
            self.lblHotelTitle.text = singleHotelDetails.title
            self.lblHotelDiscription.text = singleHotelDetails.description
            self.hotelImage.sd_setImage(with: URL(string: singleHotelDetails.image.large), placeholderImage: #imageLiteral(resourceName: "default-image"))
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    //MARK: - Setup the navigation bar
    private func setUpNav(){
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = APP_COLOR
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        let attributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        self.navigationItem.title = "Details"
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        backButton.addTarget(self, action: #selector(self.btBack(_:)), for: .touchUpInside)
        let backbuttonImage = #imageLiteral(resourceName: "back")
        let backBlackButton = backbuttonImage.withRenderingMode(.alwaysTemplate)
        backButton.setBackgroundImage(backBlackButton, for: .normal)
        backButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        
        let mapButton = UIButton(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        mapButton.addTarget(self, action: #selector(self.btMap(_:)), for: .touchUpInside)
        let mapbuttonImage = #imageLiteral(resourceName: "location")
        let mapBlackButton = mapbuttonImage.withRenderingMode(.alwaysTemplate)
        mapButton.setBackgroundImage(mapBlackButton, for: .normal)
        mapButton.tintColor = .black
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: mapButton)
    }
    
    //MARK: - setup all the UIs
    private func setUp(){
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.hotelImage)
        self.hotelImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        self.hotelImage.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        self.hotelImage.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        self.hotelImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        self.view.addSubview(self.lblHotelTitle)
        self.lblHotelTitle.topAnchor.constraint(equalTo: self.hotelImage.bottomAnchor, constant: 10).isActive = true
        self.lblHotelTitle.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        self.lblHotelTitle.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        self.view.addSubview(self.lblHotelDiscription)
        self.lblHotelDiscription.topAnchor.constraint(equalTo: self.lblHotelTitle.bottomAnchor, constant: 20).isActive = true
        self.lblHotelDiscription.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        self.lblHotelDiscription.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        self.lblHotelDiscription.bottomAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
    }
    
    @IBAction func btMap(_: Any){
        let hotelLocationVc = HotelLocationViewController(nibName: nil, bundle: nil)
        hotelLocationVc.singleHotelDetails = self.singleHotelDetails
        self.navigationController?.pushViewController(hotelLocationVc, animated: true)
    }
    
    @IBAction func btBack(_ : Any){
        self.navigationController?.popViewController(animated: true)
    }
}
