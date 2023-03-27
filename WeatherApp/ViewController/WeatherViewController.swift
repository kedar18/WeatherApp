//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Kedar Navgire on 24/03/23.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    // Outlets
    @IBOutlet weak var weatherTableView: UITableView!
    
    // Utility View
    private var searchBarController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = Constants.kInputPlaceHolder.value
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.searchTextField.clearButtonMode = .never
        return searchController
    }()
    
    // managers
    lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        return locationManager
    }()
    
    // Variables
    lazy var viewModel = GeoViewModel()
    var searchTask: DispatchWorkItem?
    var filterData:[GeoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLocationSetup()
        guard let lastKey = viewModel.autoLoad.value(forKey: Constants.kLastSearch.value) as? String else { return }
        loadWeatherDetails(searchText: lastKey)
    }
    
    private func configureView() {
        searchBarController.searchBar.delegate = self
        weatherTableView.register(UINib(nibName: Constants.kCellNibName.value, bundle: nil), forCellReuseIdentifier: Constants.kCellIdentifier.value)
        weatherTableView.tableHeaderView = searchBarController.searchBar
    }
    
    private func configureLocationSetup() {
        locationManager.delegate = self
    }
    
    private func fetchCity(from location: CLLocation, completion: @escaping (String?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { marks, error in
            completion(marks?.first?.locality)
        }
    }
    
    private func filterDataForOutput(model: [GeoModel]) {
        //sort data by US cities first as per requirements
        self.filterData = model.filter{ $0.country == Constants.kCountryCode.value }
        self.filterData.append(contentsOf: model.filter{ $0.country != Constants.kCountryCode.value })
        DispatchQueue.main.async {
            self.weatherTableView.reloadData()
        }
    }
    
}

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

extension WeatherViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchTask?.cancel()
        guard !searchText.isEmpty else { return }
        let task = DispatchWorkItem { [weak self] in
            self?.loadWeatherDetails(searchText: searchText)
        }
        searchTask = task
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.75, execute: task)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchTask?.cancel()
        weatherTableView.reloadData()
    }
}

extension WeatherViewController {
    
    func loadWeatherDetails(searchText: String) {
        
        self.viewModel.getGeoLocationDetails(searchText: searchText, completion: { [weak self] model in
            self?.viewModel.autoLoad.set(searchText, forKey: Constants.kLastSearch.value)
            self?.filterDataForOutput(model: model)
        })
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        if let location = locations.first {
            fetchCity(from: location) { [weak self] city in
                let cityName = city ?? ""
                self?.viewModel.getGeoLocationDetails(searchText: cityName) { model in
                    self?.viewModel.autoLoad.set(cityName, forKey: Constants.kLastSearch.value)
                    self?.filterDataForOutput(model: model)
                }
            }
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}
