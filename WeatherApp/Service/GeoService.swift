//
//  GeoService.swift
//  WeatherApp
//
//  Created by Kedar Navgire on 24/03/23.
//

import Foundation
import Alamofire

protocol GeoProtocol {
    func fetchLocation(query: String, completion: (([GeoModel]?) -> Void)?)
    func fetchGeoWeather(lat: Float, lon: Float, completion: ((GeoWeather) -> Void)?)
    func fetchGeoWeatherIcon(icon: String, completion: ((Data) -> Void)?)
}

class GeoService {
    
    let kAPI = Constants.kAPIKey.value
    
    func fetchLocation(query: String, completion: (([GeoModel]?) -> Void)?) {
        
        let encodeQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        AF.request("\(Constants.kBaseUrl.value)/geo/1.0/direct?q=\(encodeQuery)&limit=25&appid=\(kAPI)").responseDecodable(of: [GeoModel].self)
        { response in
                
            switch response.result {
            case .success(let model):
                completion?(model)
            case .failure(let error):
                print(error)
                completion?(nil)
            }
        }
        
    }
    
    func fetchGeoWeather(lat: Float, lon: Float, completion: ((GeoWeather) -> Void)?) {
        
        AF.request("\(Constants.kBaseUrl.value)/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(kAPI)").responseDecodable(of: GeoWrapper.self)
        { response in
            switch response.result {
            case .success(let model):
                if let weather = model.weather.first {
                    completion?(weather)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func fetchGeoWeatherIcon(icon: String, completion: ((Data) -> Void)?) {
        AF.download("\(Constants.kImageBaseUrl.value)/\(icon)@2x.png").responseData { response in
            if let data = response.value {
                completion?(data)
            }
        }
    }
}
