//
//  PersonTests.swift
//  MovieInfoTests
//
//  Created by Stuart Crook on 25/04/2023.
//

import XCTest
@testable import MovieInfo

final class PersonTests: FixtureLoadingTests {

    func testParse_PersonDetails() throws {
        let data = load(data: "person")
        
        let person = try? JSONDecoder().decode(PersonDetails.self, from: data)
        XCTAssertNotNil(person)
        XCTAssertEqual(person!.id, 2039)
        XCTAssertEqual(person!.birthday, "1955-03-29")
        XCTAssertEqual(person!.deathday, nil)
        XCTAssertEqual(person!.placeOfBirth, "Dublin, Ireland")
        XCTAssertEqual(person!.imdbId, "nm0322407")
    }

}
