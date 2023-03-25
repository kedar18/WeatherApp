//
//  GeoViewModel.swift
//  WeatherApp
//
//  Created by Kedar Navgire on 24/03/23.
//

import Foundation

class GeoViewModel {
    
    let service: GeoService
    
    init(service: GeoService = .init()) {
        self.service = service
    }
    
    func getGeoLocationDetails(searchText: String, completion: @escaping ([GeoModel]) -> Void) {
        service.fetchLocation(query: searchText, completion: completion)
    }
    
    func getCityWeather(lat: Float, lon: Float) {
        service.fetchGeoWeather(lat: lat, lon: lon) { _ in
            
        }
    }
    
}
