//
//  GeoService.swift
//  WeatherApp
//
//  Created by Kedar Navgire on 24/03/23.
//

import Foundation
import Alamofire

class GeoService {
    
    let kAPI = "7a10511986c80700b545ab77ed9c2ca2"
    
    func fetchLocation(query: String, completion: (([GeoModel]) -> Void)?) {
        
        AF.request("http://api.openweathermap.org/geo/1.0/direct?q=\(query)&limit=25&appid=\(kAPI)").responseDecodable(of: [GeoModel].self)
        { response in
            
            switch response.result {
            case .success(let model):
                completion?(model)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func fetchGeoWeather(lat: Float, lon: Float, completion: ((GeoWeather) -> Void)?) {
        
        AF.request("https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(kAPI)").responseDecodable(of: [GeoWeather].self)
        { response in
            
            switch response.result {
            case .success(let model):
                if let unwrapper = model.first {
                    completion?(unwrapper)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func fetchGeoWeatherIcon(icon: String, completion: ((URL) -> Void)?) {
        AF.download("https://openweathermap.org/img/wn/\(icon)@2x.png").responseURL { response in
            if let data = response.value {
                completion?(data)
            }
        }
    }
}
