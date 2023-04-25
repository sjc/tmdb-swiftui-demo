//
//  TVShowTests.swift
//  MovieInfoTests
//
//  Created by Stuart Crook on 25/04/2023.
//

import XCTest
@testable import MovieInfo

final class TVShowTests: FixtureLoadingTests {

    func testParse() throws {
        let details = load(fixture: "tv_show")
        let credits = load(fixture: "tv_show_credits")
        
        let tvShow = TVShow.from(details: details, credits: credits)
        XCTAssertNotNil(tvShow)
        XCTAssertEqual(tvShow!.id, 95)
        XCTAssertEqual(tvShow!.title, "Buffy the Vampire Slayer")
        XCTAssertEqual(tvShow!.posterPath, "/y7fVZkyheCEQHDUEHwNmYENGfT2.jpg")
        XCTAssertEqual(tvShow!.backdropPath, "/q4CbisNArigphVn608Faxijdw8N.jpg")
        XCTAssertEqual(tvShow!.startDate, "1997-03-10")
        XCTAssertEqual(tvShow!.endDate, "2003-05-20")
        XCTAssertEqual(tvShow!.seasons, 8)
        XCTAssertEqual(tvShow!.runtime, 43)
        XCTAssertEqual(tvShow!.tagline, "Get home before dark.")
        XCTAssertFalse(tvShow!.overview.isEmpty)
        XCTAssertEqual(tvShow!.cast.count, 7)
        XCTAssertEqual(tvShow!.crew.count, 9)
        
        XCTAssertEqual(tvShow!.activeYears, "1997 - 2003")
    }

}
