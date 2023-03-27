//
//  WeatherViewControler+Location.swift
//  WeatherApp
//
//  Created by Kedar Navgire on 27/03/23.
//

import UIKit
import CoreLocation

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if let location = locations.first {
            fetchCity(from: location) { [weak self] city in
                let cityName = city ?? ""
                self?.viewModel.getGeoLocationDetails(searchText: cityName) { model, error in
                    self?.viewModel.loadSearch = cityName
                    self?.filterDataForOutput(model: model ?? [])
                }
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            locationManager.requestLocation()
        } else if manager.authorizationStatus == .denied {
            showAlert(message: Constants.locationError.value)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showAlert(message: Constants.locationError.value)
    }
    
}
