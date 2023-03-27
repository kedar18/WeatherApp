//
//  WeatherViewController+Search.swift
//  WeatherApp
//
//  Created by Kedar Navgire on 27/03/23.
//

import UIKit

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
