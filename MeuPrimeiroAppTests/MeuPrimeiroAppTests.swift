//
//  De_Bar_em_BarTests.swift
//  De Bar em BarTests
//
//  Created by Jonathan on 29/01/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import XCTest

import MapKit
@testable import MeuPrimeiroApp

class MeuPrimeiroAppTests: XCTestCase {
    //MARK: Bar Class Tests
    
    // Confirm that the Bar initializer returns a Bar object when passed valid parameters.
    func testBarInitializationSucceeds() {
        // Zero rating
        let zeroRatingBar = Bar.init(name: "Zero", endereco: "Zero", photo: nil, rating:0 , coordinate: CLLocationCoordinate2D(latitude: 0,longitude: 0))
        XCTAssertNotNil(zeroRatingBar)
        
        // Highest positive rating
        let positiveRatingBar = Bar.init(name:"Posi", endereco:"Positive", photo: nil, rating: 5, coordinate: CLLocationCoordinate2D(latitude: 0,longitude: 0))
        XCTAssertNotNil(positiveRatingBar)
        
    }
    
    // Confirm that the Bar initialier returns nil when passed a negative rating or an empty name.
    func testBarInitializationFails() {
        // Negative rating
        let negativeRatingBar = Bar.init(name: "Negative", endereco: "AddressPlaceholder", photo: nil, rating: -1, coordinate: CLLocationCoordinate2D(latitude: 0,longitude: 0))
        XCTAssertNil(negativeRatingBar)
        
        // Empty String fields
        let emptyNameBar = Bar.init(name: "", endereco: "AddressPlaceholder", photo: nil, rating: 0, coordinate: CLLocationCoordinate2D(latitude: 0,longitude: 0))
        XCTAssertNil(emptyNameBar)
        
        let emptyAddressBar = Bar.init(name: "NamePlaceholder", endereco: "", photo: nil, rating: 0, coordinate: CLLocationCoordinate2D(latitude: 0,longitude: 0))
        XCTAssertNil(emptyAddressBar)
        
        let emptyPhoneBar = Bar.init(name: "NamePlaceholder", endereco: "AddressPlaceholder", photo: nil, rating: 0, coordinate: CLLocationCoordinate2D(latitude: 0,longitude: 0))
        XCTAssertNil(emptyPhoneBar)
        
        // Rating exceeds maximum
        let largeRatingBar = Bar.init(name: "RatingTooLarge", endereco: "AddressPlaceholder", photo: nil, rating: 6, coordinate: CLLocationCoordinate2D(latitude: 0,longitude: 0))
        XCTAssertNil(largeRatingBar)
        
        // Rating exceeds maximum
        let aboveMaximumLatitudeBar = Bar.init(name: "LatitudeTooLarge", endereco: "AddressPlaceholder", photo: nil, rating: 6, coordinate: CLLocationCoordinate2D(latitude: 0,longitude: 0))
        XCTAssertNil(aboveMaximumLatitudeBar)
        
        // Rating exceeds maximum
        let belowMinimumLatitudeBar = Bar.init(name: "LatitudeTooSmall", photo: nil, rating: 6, coordinate: CLLocationCoordinate2D(latitude: 0,longitude: 0))
        XCTAssertNil(belowMinimumLatitudeBar)
        
        // Rating exceeds maximum
        let aboveMaximumLongitudeBar = Bar.init(name: "LongitudeTooLarge",  photo: nil, rating: 6, coordinate: CLLocationCoordinate2D(latitude: 0,longitude: 0))
        XCTAssertNil(aboveMaximumLongitudeBar)
        
        // Rating exceeds maximum
        let belowMinimumLongitudeBar = Bar.init(name: "LatitudeTooSmall", photo: nil, rating: 6, coordinate: CLLocationCoordinate2D(latitude: 0,longitude: 0))
        XCTAssertNil(belowMinimumLongitudeBar)
        
    }
}

