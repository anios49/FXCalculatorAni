//
//  FXServicesTests.swift
//  FXServicesTests
//
//  Created by Animesh Mishra on 16/07/19.
//  Copyright © 2019 Animesh Mishra. All rights reserved.
//

import XCTest
@testable import FXServices

class FXServicesTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testProductionServiceRunning() {
        // Put the code you want to measure the time of here.
        setUp()
        let expectation = self.expectation(description: "Get FxRates service is failed and we don't receive correct response")
        Networking.fetchFXRates { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
                expectation.fulfill()
            default:
                XCTFail("Expected get FxRates service response with error json")
            }
        }
        self.waitForExpectations(timeout: 6.0)
    }
    
    func testServiceError() {
        let expectation = self.expectation(description: "Looks like, FxRates is not working")
        Networking.fetchFXRates(shouldFail: true) { result in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            default:
                XCTFail("Expected get FxRates service response with error json")
                
            }
        }
        self.waitForExpectations(timeout: 15.0)
    }
    
    func testCurrencyName() {
        setUp()
        let expectation = self.expectation(description: "Looks like, FxRates is having valid products")
        Networking.fetchFXRates { result in
            switch result {
            case .success(let data):
                let currencyObject = data.data?.brands?.wbc?.portfolios?.fx?.products?["USD"]
                XCTAssertEqual(currencyObject?.ProductId, "USD")
                expectation.fulfill()
            default:
                XCTFail("Expected get FxRates service response with error json")
            }
        }
        self.waitForExpectations(timeout: 6.0)
    }
    
}
