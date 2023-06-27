//
//  CreditsTests.swift
//  MovieInfoTests
//
//  Created by Stuart Crook on 27/06/2023.
//

import XCTest
@testable import MovieInfo

final class CreditsTests: FixtureLoadingTests {

    func testParseFromCredits() {

        let data = load(data: "movie_credits")

        let credits = try? JSONDecoder().decode(Credits.self, from: data)
        XCTAssertNotNil(credits)
        XCTAssertEqual(credits!.cast.count, 25)
        XCTAssertEqual(credits!.crew.count, 43)

        let castMember = credits!.cast[0]
        XCTAssertNotNil(castMember)
        XCTAssertEqual(castMember.id, 72466)
        XCTAssertEqual(castMember.popularity, 43.384)
        XCTAssertEqual(castMember.name, "Colin Farrell")
        XCTAssertEqual(castMember.department, nil)
        XCTAssertEqual(castMember.character, "Ray")
        XCTAssertEqual(castMember.job, nil)
        XCTAssertEqual(castMember.profilePath, "/8Qw0Pth12EAZDYPt6gbfpw1v734.jpg")

        let crewMember = credits!.crew[0]
        XCTAssertNotNil(crewMember)
        XCTAssertEqual(crewMember.id, 465)
        XCTAssertEqual(crewMember.popularity, 1.0)
        XCTAssertEqual(crewMember.name, "Tessa Ross")
        XCTAssertEqual(crewMember.department, "Production")
        XCTAssertEqual(crewMember.character, nil)
        XCTAssertEqual(crewMember.job, "Executive Producer")
        XCTAssertEqual(crewMember.profilePath, "/jThGwDImycWNIkHZK87qAv4uhbX.jpg")
    }
}
