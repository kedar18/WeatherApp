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
    
    func getLocation() {
        
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
    
    
}
