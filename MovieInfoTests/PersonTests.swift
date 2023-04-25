//
//  PersonTests.swift
//  MovieInfoTests
//
//  Created by Stuart Crook on 25/04/2023.
//

import XCTest
@testable import MovieInfo

final class PersonTests: FixtureLoadingTests {

    func testParse() throws {
        let json = load(fixture: "person")
        
        let person = Person.from(json: json)
        XCTAssertNotNil(person)
        XCTAssertEqual(person!.id, 2039)
        XCTAssertEqual(person!.name, "Brendan Gleeson")
        XCTAssertEqual(person!.birthday, "1955-03-29")
        XCTAssertNil(person!.deathday)
        XCTAssertEqual(person!.placeOfBirth, "Dublin, Ireland")
        XCTAssertFalse(person!.biography.isEmpty)
        XCTAssertEqual(person!.posterPath, "/379TXtBPRrkBDrEBWPQ5v3up7kT.jpg")
    }

}
