//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Capt. Ihsan on 1/16/17.
//  Copyright © 2017 Erlangga. All rights reserved.
//

import XCTest
@testable import FoodTracker


class FoodTrackerTests: XCTestCase {
    
    func testMealInitializationSucceeds(){
        let zeroRatingMeal = Meal.init(name: "Zero",photo:nil,rating:0)
        XCTAssertNotNil(zeroRatingMeal)
        
        let positiveRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingMeal)
    }
    
    func testMealInitializationFails(){
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating:-1)
        XCTAssertNil(negativeRatingMeal)
        
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 3)
        XCTAssertNil(emptyStringMeal)
        
        let largeRatingMeal = Meal(name: "Large", photo: nil, rating: 6)
        XCTAssertNil(largeRatingMeal)
    }
    
    
}
