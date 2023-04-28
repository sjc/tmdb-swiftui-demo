//
//  FitureLoadingTests.swift
//  FitureLoadingTests
//
//  Created by Stuart Crook on 24/04/2023.
//

import XCTest
@testable import MovieInfo

class FixtureLoadingTests: XCTestCase {

    func load(data filename: String) -> Data {
        let url = Bundle(for: type(of: self)).url(forResource: filename, withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    func load(fixture filename: String) -> [String:Any] {
        let data = load(data: filename)
        return try! JSONSerialization.jsonObject(with: data) as! [String:Any]
    }

}
