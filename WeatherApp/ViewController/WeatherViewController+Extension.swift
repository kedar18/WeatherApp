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
            guard let model = model, model.count >= 1 else {
                self?.searchBarController.dismiss(animated: false)
                let alert = UIAlertController(title: "Error!", message: "Please check Internet connection or input value", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
                let alert = UIAlertController(title: Constants.errorTitle.value, message: Constants.errorMessage.value, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: Constants.cancel.value, style: UIAlertAction.Style.cancel)
                alert.addAction(cancelAction)
                self?.present(alert, animated: true)
                return
            }
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
