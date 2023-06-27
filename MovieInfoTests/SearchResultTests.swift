//
//  SearchResultTests.swift
//  MovieInfoTests
//
//  Created by Stuart Crook on 25/04/2023.
//

import XCTest
@testable import MovieInfo

final class SearchResultTests: FixtureLoadingTests {

    func testParseFromSearchResponse() {

        let data = load(data: "search_multi")

        let results = try? JSONDecoder().decode(SearchResults.self, from: data)
        XCTAssertNotNil(results)
        XCTAssertEqual(results!.results.count, 20)

        // result #0 should be a person
        guard case .person(let person) = results!.results[0] else {
            XCTFail()
            return
        }
        XCTAssertEqual(person.name, "BUFFY")

        // result #1 should be a TV show
        guard case .tvShow(let tvShow) = results!.results[1] else {
            XCTFail()
            return
        }
        XCTAssertEqual(tvShow.name, "Buffy the Vampire Slayer")

        // result #2 should be a movie
        guard case .movie(let movie) = results!.results[2] else {
            XCTFail()
            return
        }
        XCTAssertEqual(movie.title, "Buffy the Vampire Slayer")
    }
}
