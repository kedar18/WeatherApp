//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Kedar Navgire on 24/03/23.
//

import UIKit

class WeatherViewController: UIViewController {
    // Outlets
    @IBOutlet weak var weatherTableView: UITableView!
    
    // Utility View
    private var searchBarController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Enter City Name"
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.searchTextField.clearButtonMode = .never
        return searchController
    }()
    
    // Variables
    lazy var viewModel = GeoViewModel()
    var searchTask: DispatchWorkItem?
    var filterData:[GeoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        guard let lastKey = viewModel.autoLoad.value(forKey: viewModel.kLastSearch) as? String else { return }
        loadWeatherDetails(searchText: lastKey)
    }
    
    private func configureView() {
        searchBarController.searchBar.delegate = self
        weatherTableView.register(UINib(nibName: "WeatherViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        weatherTableView.tableHeaderView = searchBarController.searchBar
    }

}

extension WeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherViewCell
        let model = filterData[indexPath.row]
        cell.populateCityDetails(model: model)
        cell.loadWeather(lat: model.lat, lon: model.lon)
        return cell
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
            self?.viewModel.autoLoad.set(searchText, forKey: self?.viewModel.kLastSearch ?? "")
            //sort data by US cities first as per requirements
            self?.filterData = model.filter{ $0.country == "US" }
            self?.filterData.append(contentsOf: model.filter{ $0.country != "US" })
            DispatchQueue.main.async {
                self?.weatherTableView.reloadData()
            }
        })
    }
}
