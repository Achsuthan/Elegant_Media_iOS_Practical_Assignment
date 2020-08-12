//
//  HotelListTableViewCell.swift
//  ElegantMediaiOSPracticalAssignment
//
//  Created by Achsuthan Mahendran on 8/12/20.
//  Copyright © 2020 Achsuthan Mahendran. All rights reserved.
//

import UIKit

class HotelListTableViewCell: UITableViewCell {
    
    //MARK: - Background View
    let Viewbackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Hotel Image
    let hotelImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .gray
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()
    
    //MARK: - hotel Title
    let lblTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.text = ""
        label.numberOfLines = 1
        return label
    }()
    
    //MARK: - hotel address
    let lblHotelAddress: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setup the UIs
    private func setUp(){
        //set up the background view
        self.addSubview(self.Viewbackground)
        self.Viewbackground.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.Viewbackground.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.Viewbackground.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.Viewbackground.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.Viewbackground.heightAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
        
        //set up the hotel image
        self.Viewbackground.addSubview(self.hotelImage)
        self.hotelImage.leadingAnchor.constraint(equalTo: self.Viewbackground.leadingAnchor, constant: 10).isActive = true
        self.hotelImage.centerYAnchor.constraint(equalTo: self.Viewbackground.centerYAnchor).isActive = true
        self.hotelImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.hotelImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.hotelImage.layer.cornerRadius = 30
        
        //setup the hotel title
        self.Viewbackground.addSubview(self.lblTitle)
        self.lblTitle.topAnchor.constraint(equalTo: self.hotelImage.topAnchor).isActive = true
        self.lblTitle.leadingAnchor.constraint(equalTo: self.hotelImage.trailingAnchor, constant: 10).isActive = true
        self.lblTitle.trailingAnchor.constraint(equalTo: self.Viewbackground.trailingAnchor, constant: -10).isActive = true
        
        //setup the hotel address
        self.Viewbackground.addSubview(self.lblHotelAddress)
        self.lblHotelAddress.topAnchor.constraint(equalTo: self.lblTitle.bottomAnchor, constant: 5).isActive = true
        self.lblHotelAddress.leadingAnchor.constraint(equalTo: self.hotelImage.trailingAnchor, constant: 10).isActive = true
        self.lblHotelAddress.trailingAnchor.constraint(equalTo: self.Viewbackground.trailingAnchor, constant: -10).isActive = true
        self.lblHotelAddress.bottomAnchor.constraint(equalTo: self.hotelImage.bottomAnchor).isActive = true
    }
}
