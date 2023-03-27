//
//  WeatherViewController+TableViewExtension.swift
//  WeatherApp
//
//  Created by Kedar Navgire on 27/03/23.
//

import UIKit

extension WeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kCellIdentifier.value, for: indexPath) as! WeatherViewCell
        let model = filterData[indexPath.row]
        cell.populateCityDetails(model: model)
        cell.loadWeather(lat: model.lat, lon: model.lon)
        return cell
    }
    
}

extension WeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
}
