//
//  WeatherViewCell.swift
//  WeatherApp
//
//  Created by Kedar Navgire on 24/03/23.
//

import UIKit

class WeatherViewCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var stateName: UILabel!
    @IBOutlet weak var lat: UILabel!
    @IBOutlet weak var lon: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    
    let viewModel = GeoViewModel()
    var weatherCompletion: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func populateCityDetails(model: GeoModel) {
        self.cityName.text = "City: " + model.name
        self.countryName.text = "Country: " + model.country
        if let region = model.state {
            self.stateName.text = "State: \(region)"
        }
        self.lat.text = "Latitude:\n\(model.lat)"
        self.lon.text = "Longitude:\n\(model.lon)"
    }
    
    func loadWeather(lat: Float, lon: Float) {
        viewModel.getCityWeather(lat: lat, lon: lon) { model in
            print(model.main)
        }
    }
    
    private func populateWeather() {
        
    }
    
}
