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
        return searchController
    }()
    
    // Variables
    lazy var viewModel = GeoViewModel()
    var searchTask: DispatchWorkItem?
    
    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
            "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
            "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
            "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
            "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    
    var filterData:[GeoModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        searchBarController.searchBar.delegate = self
        weatherTableView.tableHeaderView = searchBarController.searchBar
    }

}

extension WeatherViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filterData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      let model = filterData[indexPath.row]
      cell.textLabel?.text = model.name + "," + model.country
    return cell
  }
}

extension WeatherViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.searchTask?.cancel()
        guard !searchText.isEmpty else { return }
        let task = DispatchWorkItem { [weak self] in
            self?.viewModel.getGeoLocationDetails(searchText: searchText, completion: { model in
                //sort data by US cities first as per requirements
                self?.filterData = model.filter{ $0.country == "US" }
                self?.filterData.append(contentsOf: model.filter{ $0.country != "US" })
                DispatchQueue.main.async {
                    self?.weatherTableView.reloadData()
                }
            })
        }
        searchTask = task
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.75, execute: task)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchTask?.cancel()
        weatherTableView.reloadData()
    }
}
