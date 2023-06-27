//
//  TVShowTests.swift
//  MovieInfoTests
//
//  Created by Stuart Crook on 25/04/2023.
//

import XCTest
@testable import MovieInfo

final class TVShowTests: FixtureLoadingTests {

    func testParse_TVShowDetails() throws {
        let data = load(data: "tv_show")
        let tvShow = try? JSONDecoder().decode(TVShowDetails.self, from: data)
        XCTAssertNotNil(tvShow)
        XCTAssertEqual(tvShow!.id, 95)
        XCTAssertEqual(tvShow!.tagline, "Get home before dark.")

        XCTAssertEqual(tvShow!.createdBy.count, 1)
        XCTAssertEqual(tvShow!.createdBy[0].id, 12891)
        XCTAssertEqual(tvShow!.createdBy[0].name, "Joss Whedon")

        XCTAssertEqual(tvShow!.numberOfEpisodes, 144)
        XCTAssertEqual(tvShow!.numberOfSeasons, 7)
        XCTAssertEqual(tvShow!.episodeRunTimes, [43])
        XCTAssertEqual(tvShow!.runtimeMins, "43 mins")

        XCTAssertEqual(tvShow!.firstAirDate, "1997-03-10")
        XCTAssertEqual(tvShow!.lastAirDate, "2003-05-20")
        XCTAssertEqual(tvShow!.activeYears, "1997 - 2003")
    }

}
