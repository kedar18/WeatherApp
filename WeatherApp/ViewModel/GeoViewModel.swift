//
//  GeoViewModel.swift
//  WeatherApp
//
//  Created by Kedar Navgire on 24/03/23.
//

import Foundation

class GeoViewModel {
    
    let service: GeoService
    let autoLoad = UserDefaults.standard
    
    init(service: GeoService = .init()) {
        self.service = service
    }
    
    func getGeoLocationDetails(searchText: String, completion: @escaping ([GeoModel]) -> Void) {
        service.fetchLocation(query: searchText, completion: completion)
    }
    
    func getCityWeather(lat: Float, lon: Float, completion: @escaping (GeoWeather) -> Void) {
        service.fetchGeoWeather(lat: lat, lon: lon, completion: completion )
    }
    
    func getGeoWeatherIcon(iconString: String, completion: @escaping (Data) -> Void) {
        service.fetchGeoWeatherIcon(icon: iconString, completion: completion)
    }
    
}
