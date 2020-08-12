//
//  RequestUrls.swift
//  Quirk
//
//  Created by Achsuthan Mahendran on 8/12/20.
//  Copyright © 2020 Achsuthan Mahendran. All rights reserved.
//

import Foundation

private var port: String = "sandBox"

struct RequestUrls {
    //URLs
    private static var sandboxUrl = "https://dl.dropboxusercontent.com/"  //Dev
    private static var liveUrl = ""
    
    
    public static func getBaseUrlStatus() -> String{
        return port
    }
    
    public static func getBaseUrl() -> String {
        switch port {
        case "sandBox":
            return sandboxUrl
        case "live":
            return liveUrl
        default:
            return sandboxUrl
        }
    }
    static var getHotelDetails: String {
        return getBaseUrl() + "s/6nt7fkdt7ck0lue/hotels.json"
    }
}

