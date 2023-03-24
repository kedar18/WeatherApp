//
//  GeoService.swift
//  WeatherApp
//
//  Created by Kedar Navgire on 24/03/23.
//

import Foundation
import Alamofire

class GeoService {
    
    static let shared = GeoService()
    
    func fetchLocation() {
        
        AF.request("http://api.openweathermap.org/geo/1.0/direct?q=London&limit=5&appid=7a10511986c80700b545ab77ed9c2ca2").responseDecodable(of: [GeoModel].self)
        { response in
            
            switch response.result {
                
            case .success(let json):
                print(json)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func fetchGeoWeather() {
        
        AF.request("https://api.openweathermap.org/data/2.5/weather?lat=51.515618&lon=-0.091998&appid=7a10511986c80700b545ab77ed9c2ca2").responseDecodable(of: GeoWrapper.self)
        { response in
            
            switch response.result {
                
            case .success(let json):
                print(json)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}
