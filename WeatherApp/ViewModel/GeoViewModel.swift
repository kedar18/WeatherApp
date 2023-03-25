//
//  GeoViewModel.swift
//  WeatherApp
//
//  Created by Kedar Navgire on 24/03/23.
//

import Foundation

class GeoViewModel {
    
    let service: GeoServicex`
    
    init(service: GeoService = .init()) {
        self.service = service
    }
    
    func getGeoLocationDetails(searchText: String, completion: @escaping ([GeoModel]) -> Void) {
        service.fetchLocation(query: searchText, completion: completion)
    }
    
    func getCityWeather(lat: Float, lon: Float) {
        service.fetchGeoWeather(lat: lat, lon: lon) {[weak self] details in
            let model = self?.displayModel.filter { data in
                if data.lat == lat {
                    
                    return true
                }
                return false
            }
            
        }
    }
    
}
