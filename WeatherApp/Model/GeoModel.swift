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
