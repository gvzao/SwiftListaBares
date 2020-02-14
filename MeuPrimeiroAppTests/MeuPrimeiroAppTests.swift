//
//  De_Bar_em_BarTests.swift
//  De Bar em BarTests
//
//  Created by Jonathan on 29/01/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import XCTest
@testable import MeuPrimeiroApp

class MeuPrimeiroAppTests: XCTestCase {
    //MARK: Bar Class Tests
    
    // Confirm that the Bar initializer returns a Bar object when passed valid parameters.
    func testBarInitializationSucceeds() {
        // Zero rating
        let zeroRatingBar = Bar.init(name: "Zero", endereco: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingBar)
        
        // Highest positive rating
        let positiveRatingBar = Bar.init(name:"Positive", endereco:"Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingBar)
        
        // Maximum latitude/longitude values
        let maximumCoordinatesValuesBar = Bar.init(name: "Maximum", endereco: "Maximum", photo: nil, rating: 5)
        XCTAssertNotNil(maximumCoordinatesValuesBar)
        
        // Minimum latitude/longitude values
        let minimumCoordinatesValuesBar = Bar.init(name: "Minimum", endereco: "Minimum", photo: nil, rating: 5)
        XCTAssertNotNil(minimumCoordinatesValuesBar)
    }
    
    // Confirm that the Bar initialier returns nil when passed a negative rating or an empty name.
    func testBarInitializationFails() {
        // Negative rating
        let negativeRatingBar = Bar.init(name: "Negative", endereco: "AddressPlaceholder", telefone: "123456789", telefone: nil, rating: -1)
        XCTAssertNil(negativeRatingBar)
        
        // Empty String fields
        let emptyNameBar = Bar.init(name: "", endereco: "AddressPlaceholder", telefone: "123456789", photo: nil, rating: 0)
        XCTAssertNil(emptyNameBar)
        
        let emptyAddressBar = Bar.init(name: "NamePlaceholder", endereco: "", telefone: "12345678", photo: nil, rating: 0)
        XCTAssertNil(emptyAddressBar)
        
        let emptyPhoneBar = Bar.init(name: "NamePlaceholder", endereco: "AddressPlaceholder", telefone: "", photo: nil, rating: 0)
        XCTAssertNil(emptyPhoneBar)
        
        // Rating exceeds maximum
        let largeRatingBar = Bar.init(name: "RatingTooLarge", endereco: "AddressPlaceholder", telefone: "123456789", photo: nil, rating: 6)
        XCTAssertNil(largeRatingBar)
        
        // Rating exceeds maximum
        let aboveMaximumLatitudeBar = Bar.init(name: "LatitudeTooLarge", endereco: "AddressPlaceholder", telefone: "123456789", photo: nil, rating: 6)
        XCTAssertNil(aboveMaximumLatitudeBar)
        
        // Rating exceeds maximum
        let belowMinimumLatitudeBar = Bar.init(name: "LatitudeTooSmall", endereco: "AddressPlaceholder", telefone: "123456789", photo: nil, rating: 6)
        XCTAssertNil(belowMinimumLatitudeBar)
        
        // Rating exceeds maximum
        let aboveMaximumLongitudeBar = Bar.init(name: "LongitudeTooLarge", endereco: "AddressPlaceholder", telefone: "123456789", telefone: nil, rating: 6)
        XCTAssertNil(aboveMaximumLongitudeBar)
        
        // Rating exceeds maximum
        let belowMinimumLongitudeBar = Bar.init(name: "LatitudeTooSmall", endereco: "AddressPlaceholder", telefone: "123456789", photo: nil, rating: 6)
        XCTAssertNil(belowMinimumLongitudeBar)
    }
}

