//
//  MovieTests.swift
//  MovieInfoTests
//
//  Created by Stuart Crook on 25/04/2023.
//

import XCTest
@testable import MovieInfo

final class MovieTests: FixtureLoadingTests {

    func testParse() throws {
        let details = load(fixture: "movie")
        let credits = load(fixture: "movie_credits")
        
        let movie = Movie.from(details: details, credits: credits)
        XCTAssertNotNil(movie)
        XCTAssertEqual(movie!.id, 8321)
        XCTAssertEqual(movie!.title, "In Bruges")
        XCTAssertEqual(movie!.posterPath, "/jMiBBqk72VRo1Y39x2ZbbenEU3a.jpg")
        XCTAssertEqual(movie!.backdropPath, "/dtGxDOcFssdUUTYBr6M6INXTI1e.jpg")
        XCTAssertEqual(movie!.releaseDate, "2008-02-08")
        XCTAssertEqual(movie!.runtime, 108)
        XCTAssertEqual(movie!.tagline, "Shoot first. Sightsee later.")
        XCTAssertFalse(movie!.overview.isEmpty)
        XCTAssertEqual(movie!.cast.count, 25)
        XCTAssertEqual(movie!.crew.count, 43)
    }

}
