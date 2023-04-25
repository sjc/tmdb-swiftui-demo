//
//  FitureLoadingTests.swift
//  FitureLoadingTests
//
//  Created by Stuart Crook on 24/04/2023.
//

import XCTest
@testable import MovieInfo

class FixtureLoadingTests: XCTestCase {
    
    func load(fixture filename: String) -> [String:Any] {
        let url = Bundle(for: type(of: self)).url(forResource: filename, withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return try! JSONSerialization.jsonObject(with: data) as! [String:Any]
    }

}
