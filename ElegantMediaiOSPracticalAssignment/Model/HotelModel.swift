//
//  HotelModel.swift
//  ElegantMediaiOSPracticalAssignment
//
//  Created by Achsuthan Mahendran on 8/12/20.
//  Copyright © 2020 Achsuthan Mahendran. All rights reserved.
//

import Foundation

struct HotelModel: Codable {
    var id: Int
    var description: String
    var title: String
    var latitude: String
    var image : Image
    var postcode: String
    var address: String
    var phoneNumber: String
    var longitude: String
}

struct Image: Codable {
    var small: String
    var medium: String
    var large: String
}
