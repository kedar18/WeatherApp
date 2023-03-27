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
    private lazy var searchBarController: UISearchController = {
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
    
}
