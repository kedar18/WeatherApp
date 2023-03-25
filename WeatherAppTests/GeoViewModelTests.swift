//
//  GeoViewModelTests.swift
//  WeatherAppTests
//
//  Created by Kedar Navgire on 26/03/23.
//

import XCTest
@testable import WeatherApp

final class GeoViewModelTests: XCTestCase {
    
    var viewModel: GeoViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = GeoViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }

    func test_init() {
        viewModel = GeoViewModel(service: .init())
    }
    
    func test_geoLocation_ExpectedValue() {
        viewModel.getGeoLocationDetails(searchText: "London") { model in
            XCTAssertNotNil(model)
            XCTAssertEqual(model.count, 5)
            XCTAssertEqual(model.first?.state, "London")
        }
    }
    
    func test_geoLocation_UnExpectedValue() {
        viewModel.getGeoLocationDetails(searchText: "zxy") { model in
            XCTAssertNil(model)
        }
    }
    
    func test_geoDetails_Input_latlonValue() {
        viewModel.service.fetchGeoWeather(lat: -65.6383, lon: 18.2723) { model in
            XCTAssertNotNil(model)
            XCTAssertEqual(model.main, "Clear")
            XCTAssertEqual(model.description, "clear sky")
        }
    }

}
