//
//  HeaderHelper.swift
//  Quirk
//
//  Created by Achsuthan Mahendran on 8/12/20.
//  Copyright © 2020 Achsuthan Mahendran. All rights reserved.
//
import Foundation


class HeaderHelper {
    
    
    
    static func getCommonHeaders(withAuth: Bool = true) -> [String: String] {
        
        let headers = ["Accept": "application/json",
                       "Content-Type": "application/json",
                       "device": "ios",
                       "version": "1"]
        return headers
    }
    
}
