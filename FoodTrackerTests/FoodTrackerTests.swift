//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Julia Castro on 7/25/16.
//  Copyright © 2016 Julia Castro. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    //MARK: FoodTracker Tests
    
    //tests to confirm that the Meal Initializer returns when no name or a negative rating is provided
    func testMealInitialization(){
        //success case
        let potentialItem = Meal(name: "Newest meal", photo: nil, rating: 5)
        XCTAssertNotNil(potentialItem)
        
        //failure case
        let noName = Meal(name: "", photo: nil, rating: 0)
        XCTAssertNil(noName, "Empty name is invalid")
        
        let badRating = Meal(name: "Really Bad Rating", photo: nil, rating: -1)
        XCTAssertNil(badRating)
        
    }
}
