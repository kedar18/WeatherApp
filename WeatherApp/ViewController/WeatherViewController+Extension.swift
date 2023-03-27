//
//  WeatherViewController+Extension.swift
//  WeatherApp
//
//  Created by Kedar Navgire on 27/03/23.
//

import UIKit
import CoreLocation

extension WeatherViewController {
    
    func loadWeatherDetails(searchText: String) {
        viewModel.getGeoLocationDetails(searchText: searchText, completion: { [weak self] model in
            self?.viewModel.autoLoad.set(searchText, forKey: Constants.kLastSearch.value)
            self?.filterDataForOutput(model: model)
        })
    }
    
    func filterDataForOutput(model: [GeoModel]) {
        //sort data by US cities first as per requirements
        filterData = model.filter{ $0.country == Constants.kCountryCode.value }
        filterData.append(contentsOf: model.filter{ $0.country != Constants.kCountryCode.value })
        DispatchQueue.main.async {
            self.weatherTableView.reloadData()
        }
    }
    
    func fetchCity(from location: CLLocation, completion: @escaping (String?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { marks, error in
            completion(marks?.first?.locality)
        }
    }
}
