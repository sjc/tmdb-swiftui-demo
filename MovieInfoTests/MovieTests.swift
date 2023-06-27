//
//  MovieTests.swift
//  MovieInfoTests
//
//  Created by Stuart Crook on 25/04/2023.
//

import XCTest
@testable import MovieInfo

final class MovieTests: FixtureLoadingTests {

    func testParse_MovieDetails() throws {
        let data = load(data: "movie")
        let movie = try? JSONDecoder().decode(MovieDetails.self, from: data)
        XCTAssertNotNil(movie)
        XCTAssertEqual(movie!.id, 8321)
        XCTAssertEqual(movie!.tagline, "Shoot first. Sightsee later.")
        XCTAssertEqual(movie!.runtime, 108)
        XCTAssertEqual(movie!.budget, 15000000)
        XCTAssertEqual(movie!.revenue, 34533783)
        XCTAssertEqual(movie!.imdbId, "tt0780536")
    }

}
