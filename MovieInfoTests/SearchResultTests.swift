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
        let json = load(fixture: "search_multi")
        let results = json["results"] as! [[String:Any]]
        
        // result #0 should be a person
        let person = SearchResult.from(json: results[0])
        XCTAssertNotNil(person)
        XCTAssertEqual(person!.mediaType, .person)
        
        // result #1 should be a TV show
        let tvShow = SearchResult.from(json: results[1])
        XCTAssertNotNil(tvShow)
        XCTAssertEqual(tvShow!.mediaType, .tv)
        
        // result #3 should be a movie
        let movie = SearchResult.from(json: results[2])
        XCTAssertNotNil(movie)
        XCTAssertEqual(movie!.mediaType, .movie)
    }
    
    func testParseFromCredits() {
        let json = load(fixture: "movie_credits")
        let cast = json["cast"] as! [[String:Any]]
        let crew = json["crew"] as! [[String:Any]]

        let castMember = SearchResult.from(cast: cast[0])
        XCTAssertNotNil(castMember)
        XCTAssertEqual(castMember!.mediaType, .person)
        XCTAssertEqual(castMember!.id, 72466)
        XCTAssertEqual(castMember!.popularity, 43.384)
        XCTAssertEqual(castMember!.title, "Colin Farrell")
        XCTAssertEqual(castMember!.subtitle, "Ray")
        XCTAssertEqual(castMember!.posterPath, "/8Qw0Pth12EAZDYPt6gbfpw1v734.jpg")
        XCTAssertNil(castMember!.backgroundPath)

        let crewMember = SearchResult.from(crew: crew[0])
        XCTAssertNotNil(crewMember)
        XCTAssertEqual(crewMember!.mediaType, .person)
        XCTAssertEqual(crewMember!.id, 465)
        XCTAssertEqual(crewMember!.popularity, 1.0)
        XCTAssertEqual(crewMember!.title, "Tessa Ross")
        XCTAssertEqual(crewMember!.subtitle, "Executive Producer")
        XCTAssertEqual(crewMember!.posterPath, "/jThGwDImycWNIkHZK87qAv4uhbX.jpg")
        XCTAssertNil(crewMember!.backgroundPath)
    }

}
