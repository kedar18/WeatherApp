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
        searchController.searchBar.placeholder = "Enter US City Name"
        searchController.searchBar.searchBarStyle = .minimal
        return searchController
    }()
    
    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
            "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
            "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
            "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
            "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
    
    var filterData:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterData = data
        searchBarController.searchBar.delegate = self
        weatherTableView.tableHeaderView = searchBarController.searchBar
        
        GeoService.shared.getLocation()
    }

}

extension WeatherViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filterData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = filterData[indexPath.row]
    return cell
  }
}

extension WeatherViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
        filterData = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        weatherTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filterData = data
        weatherTableView.reloadData()
    }
}
