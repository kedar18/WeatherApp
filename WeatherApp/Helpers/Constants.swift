//
//  Constants.swift
//  WeatherApp
//
//  Created by Kedar Navgire on 27/03/23.
//

import Foundation

enum Constants: String {
    case kAPIKey = "7a10511986c80700b545ab77ed9c2ca2"
    case kBaseUrl = "http://api.openweathermap.org"
    case kImageBaseUrl = "https://openweathermap.org/img/wn"
    case kCellIdentifier = "cell"
    case kCellNibName = "WeatherViewCell"
    case kInputPlaceHolder = "Enter City Name"
    case kCountryCode = "US"
    case kLastSearch = "last_search"
    case errorTitle = "Error!"
    case errorMessage = "Please check Internet connection or input value"
    case cancel = "Cancel"
    case locationError = "Please Check Location permission!"
    
    var value: String {
        return self.rawValue
    }
}
