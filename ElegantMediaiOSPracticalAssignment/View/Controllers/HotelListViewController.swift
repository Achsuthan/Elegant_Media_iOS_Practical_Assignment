//
//  HotelListViewController.swift
//  ElegantMediaiOSPracticalAssignment
//
//  Created by Achsuthan Mahendran on 8/12/20.
//  Copyright © 2020 Achsuthan Mahendran. All rights reserved.
//

import UIKit
import SDWebImage
import FBSDKLoginKit

class HotelListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, passAPIDetails{
    
    func passAPIDetailsFn() {
        self.hotelTableView.reloadData()
    }
    
    //MARK: - set how many rows in a tableview based on the API response
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hotelViewModel.getHotelCount()
    }
    
    
    //MARK: - Setup the view for each cell with the relevent information
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let view  = tableView.dequeueReusableCell(withIdentifier: "HotelListTableViewCell", for: indexPath) as! HotelListTableViewCell
        let singleData = self.hotelViewModel.getSingleHotel(indexPath.row)
        view.selectionStyle = .none
        view.lblTitle.text = singleData.title
        view.lblHotelAddress.text = singleData.address
        view.hotelImage.sd_setImage(with: URL(string: singleData.image.small), placeholderImage: #imageLiteral(resourceName: "default-image"))
        return view
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected indexpath", indexPath)
        let hotelDetailsView = HotelDetailsViewController(nibName: nil, bundle: nil)
        hotelDetailsView.singleHotelDetails = self.hotelViewModel.getSingleHotel(indexPath.row)
        self.navigationController?.pushViewController(hotelDetailsView, animated: true)
    }
    
    
    //MARK: - Name label
    let lblName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.text = "Achsuthan Mahendran"
        return label
    }()
    
    //MARK: - Email label
    let lblEmail: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.text = "achsuthan@icloud.com"
        return label
    }()
    
    //MARK: - Button for Facebook
    let btLogout: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = APP_COLOR
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    //Mark: - Tableview for list the hotel
    let hotelTableView: UITableView = {
        let tabel = UITableView()
        tabel.translatesAutoresizingMaskIntoConstraints = false
        return tabel
    }()
    
    let hotelViewModel = HotelViewModel()
    
    //Name from parent view
    var name: String = "" {
        didSet{
            self.lblName.text = self.name
        }
    }
    //Email form parent view
    var email: String = "" {
        didSet {
            self.lblEmail.text = self.email
        }
    }
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
        self.navigationItem.title = "List View"
    }
    
    //MARK: - Setup the full UI
    private func setUp(){
        self.view.backgroundColor = .white
        
        //Set up the name
        self.view.addSubview(self.lblName)
        self.lblName.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        self.lblName.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        self.lblName.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        //set Up the email address
        self.view.addSubview(self.lblEmail)
        self.lblEmail.topAnchor.constraint(equalTo: self.lblName.bottomAnchor).isActive = true
        self.lblEmail.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        self.lblEmail.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        //set Up the logout button
        self.view.addSubview(self.btLogout)
        self.btLogout.topAnchor.constraint(equalTo: self.lblEmail.bottomAnchor, constant: 5).isActive = true
        self.btLogout.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.btLogout.heightAnchor.constraint(equalToConstant: 35).isActive = true
        self.btLogout.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        self.btLogout.addTarget(self, action: #selector(self.btLogout(_:)), for: .touchUpInside)
//        self.btLogout.delegate = self
        
        //set up hotel listing tableview
        self.view.addSubview(self.hotelTableView)
        self.hotelTableView.topAnchor.constraint(equalTo: self.btLogout.bottomAnchor, constant: 10).isActive = true
        self.hotelTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.hotelTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.hotelTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        //Register table view cell and delegate and datsouce to this view
        self.hotelTableView.register(HotelListTableViewCell.self, forCellReuseIdentifier: "HotelListTableViewCell")
        self.hotelTableView.delegate = self
        self.hotelTableView.dataSource = self
        
        //Featch the details from API
        self.hotelViewModel.getAllHotelDetails()
        self.hotelViewModel.delegate = self
    }
    
    
    //MARK: - Logout button handler
    @IBAction func btLogout(_ : Any){
        let loginManger = LoginManager()
        loginManger.logOut()
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.viewControllers = [LoginViewController(nibName: nil, bundle: nil)]
    }
    
}
