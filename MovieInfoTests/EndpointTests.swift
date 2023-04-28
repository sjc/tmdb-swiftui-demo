//
//  EndpointTests.swift
//  MovieInfoTests
//
//  Created by Stuart Crook on 28/04/2023.
//

import XCTest
@testable import MovieInfo

final class EndpointTests: XCTestCase {

    func testSearchEndpoint() throws {
        let endpoint = Endpoint.search(term: "the search term")
        let request = endpoint.request(with: "my_api_key")
        XCTAssertEqual(request.url?.absoluteString, "https://api.themoviedb.org/3/search/multi?query=the%20search%20term&include_adult=false&api_key=my_api_key")
    }

    func testMoviesEndpoint() throws {
        let endpoint = Endpoint.movies(id: 21)
        let request = endpoint.request(with: "my_api_key")
        XCTAssertEqual(request.url?.absoluteString, "https://api.themoviedb.org/3/movie/21?api_key=my_api_key")
    }

    func testMovieCreditsEndpoint() throws {
        let endpoint = Endpoint.movieCredits(id: 21)
        let request = endpoint.request(with: "my_api_key")
        XCTAssertEqual(request.url?.absoluteString, "https://api.themoviedb.org/3/movie/21/credits?api_key=my_api_key")
    }

    func testTVShowsEndpoint() throws {
        let endpoint = Endpoint.tvShows(id: 21)
        let request = endpoint.request(with: "my_api_key")
        XCTAssertEqual(request.url?.absoluteString, "https://api.themoviedb.org/3/tv/21?api_key=my_api_key")
    }

    func testTVShowCreditsEndpoint() throws {
        let endpoint = Endpoint.tvShowCredits(id: 21)
        let request = endpoint.request(with: "my_api_key")
        XCTAssertEqual(request.url?.absoluteString, "https://api.themoviedb.org/3/tv/21/credits?api_key=my_api_key")
    }

    func testPersonEndpoint() throws {
        let endpoint = Endpoint.person(id: 21)
        let request = endpoint.request(with: "my_api_key")
        XCTAssertEqual(request.url?.absoluteString, "https://api.themoviedb.org/3/person/21?api_key=my_api_key")
    }

}
