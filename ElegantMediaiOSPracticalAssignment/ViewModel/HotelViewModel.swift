//
//  HotelViewModel.swift
//  ElegantMediaiOSPracticalAssignment
//
//  Created by Achsuthan Mahendran on 8/12/20.
//  Copyright © 2020 Achsuthan Mahendran. All rights reserved.
//

import Foundation

protocol passAPIDetails {
    func passAPIDetailsFn()
}

class HotelViewModel {
    
    var delegate: passAPIDetails!
    private var allHotels: [HotelModel] = []
    
    //Get the total count of all hotels
    public func getHotelCount()-> Int{
        return allHotels.count
    }
    
    //Get the single hotel based on the index
    public func getSingleHotel(_ index: Int) -> HotelModel {
        return self.allHotels[index]
    }
    
    //Fetch all the hotel details from API
    public func getAllHotelDetails(){
        UserHelper.callAPI(urlName: .getHotelDetails, method: .get, parameters: [:]) {[weak self] (status, result, error) in
            if status {
                let response = result?.dictionaryObject!
                let status = response!["status"] as! Int
                
                if status == 200 {
                    //Success will go here
                    if let jsonData = try? JSONEncoder().encode(result!["data"] ),
                        let jsonString = String(data: jsonData, encoding: .utf8) {
                        if let data = jsonString.data(using: .utf8),
                            let hotelData = try? JSONDecoder().decode([HotelModel].self, from: data) {
                            self?.allHotels = hotelData
                        }
                    }
                    
                    self?.delegate.passAPIDetailsFn()
                }
                else {
                    //Fail hanlder
                }
            }
            else {
                //Fail handler
            }
        }
    }
}
