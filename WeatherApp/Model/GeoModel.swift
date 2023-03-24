//
//  GeoModel.swift
//  WeatherApp
//
//  Created by Kedar Navgire on 24/03/23.
//

import Foundation

struct GeoModel: Decodable {
    
    let name: String
    let lat: Float
    let lon: Float
    let country: String
    let state: String?
    
}

struct GeoWrapper: Decodable {
    
    let weather: [GeoWeather]
}

struct GeoWeather: Decodable {
    
    let main: String
    let description: String
    let icon: String
}

