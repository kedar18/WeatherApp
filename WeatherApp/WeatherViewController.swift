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
    private var searchBar: UISearchController = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.weatherTableView.tableHeaderView = searchBar.searchBar
    }

}

extension WeatherViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = data[indexPath.row]
    return cell
  }
}
