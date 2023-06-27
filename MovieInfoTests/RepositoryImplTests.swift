//
//  RepositoryImplTests.swift
//  MovieInfoTests
//
//  Created by Stuart Crook on 28/04/2023.
//

import XCTest
@testable import MovieInfo

final class RepositoryImplTests: FixtureLoadingTests {

    let mockDataFetcher = MockDataFetcher()
    let apiKey = "my_api_key"
    var repository: Repository!
    
    override func setUpWithError() throws {
        repository = RepositoryImpl(apiKey: apiKey, dataFetcher: mockDataFetcher)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearch_success() async throws {
        // Given
        mockDataFetcher.dataToReturn = [
            load(data: "search_multi")
        ]
        mockDataFetcher.responsesToReturn = [
            URLResponse()
        ]
        
        // When
        let result = await repository.search(term: "search term")
        
        // Then
        guard case .success(let results) = result else {
            XCTFail("should have returned results")
            return
        }
        XCTAssertEqual(results.count, 20)
        
        XCTAssertEqual(mockDataFetcher.dataForCalledCount, 1)
        XCTAssertEqual(mockDataFetcher.requestsPassed.count, 1)
        XCTAssertEqual(mockDataFetcher.requestsPassed[0].url?.absoluteString, "https://api.themoviedb.org/3/search/multi?query=search%20term&include_adult=false&api_key=my_api_key")
    }
    
    func testSearch_apiError() async throws {
        // Given
        mockDataFetcher.dataToReturn = [
            load(data: "error") // an API error
        ]
        mockDataFetcher.responsesToReturn = [
            URLResponse()
        ]
        
        // When
        let result = await repository.search(term: "search term")
        
        // Then
        guard case .failure(let error) = result, let error = error as? RepositoryError else {
            XCTFail("should have returned a RepositoryError")
            return
        }
        guard case .tmdb(let code, let message) = error else {
            XCTFail("should have returned a TMDB error")
            return
        }
        XCTAssertEqual(code, 34)
        XCTAssertEqual(message, "The resource you requested could not be found.")

        XCTAssertEqual(mockDataFetcher.dataForCalledCount, 1)
        XCTAssertEqual(mockDataFetcher.requestsPassed.count, 1)
        XCTAssertEqual(mockDataFetcher.requestsPassed[0].url?.absoluteString, "https://api.themoviedb.org/3/search/multi?query=search%20term&include_adult=false&api_key=my_api_key")
    }

    func testMovies_success() async throws {
        // Given
        mockDataFetcher.dataToReturn = [
            load(data: "movie"),
            load(data: "movie_credits")
        ]
        mockDataFetcher.responsesToReturn = [
            URLResponse(),
            URLResponse()
        ]
        
        // When
        let result = await repository.fetch(movieId: 21)
        
        // Then
        guard case .success(let movie) = result else {
            XCTFail("should have returned a Movie")
            return
        }
        XCTAssertEqual(movie.id, 8321) // value from fixture, not parameter
        XCTAssertEqual(movie.cast?.count, 25)
        XCTAssertEqual(movie.crew?.count, 43)
        
        XCTAssertEqual(mockDataFetcher.dataForCalledCount, 2)
        XCTAssertEqual(mockDataFetcher.requestsPassed.count, 2)
        XCTAssertEqual(mockDataFetcher.requestsPassed[0].url?.absoluteString, "https://api.themoviedb.org/3/movie/21?api_key=my_api_key")
        XCTAssertEqual(mockDataFetcher.requestsPassed[1].url?.absoluteString, "https://api.themoviedb.org/3/movie/21/credits?api_key=my_api_key")
    }
    
    func testTVShows_success() async throws {
        // Given
        mockDataFetcher.dataToReturn = [
            load(data: "tv_show"),
            load(data: "tv_show_credits")
        ]
        mockDataFetcher.responsesToReturn = [
            URLResponse(),
            URLResponse()
        ]
        
        // When
        let result = await repository.fetch(tvShowId: 21)
        
        // Then
        guard case .success(let tvShow) = result else {
            XCTFail("should have returned a TVShow")
            return
        }
        XCTAssertEqual(tvShow.id, 95) // value from fixture, not parameter
        XCTAssertEqual(tvShow.cast?.count, 7)
        XCTAssertEqual(tvShow.crew?.count, 9)

        XCTAssertEqual(mockDataFetcher.dataForCalledCount, 2)
        XCTAssertEqual(mockDataFetcher.requestsPassed.count, 2)
        XCTAssertEqual(mockDataFetcher.requestsPassed[0].url?.absoluteString, "https://api.themoviedb.org/3/tv/21?api_key=my_api_key")
        XCTAssertEqual(mockDataFetcher.requestsPassed[1].url?.absoluteString, "https://api.themoviedb.org/3/tv/21/credits?api_key=my_api_key")
    }
    
    func testPerson_success() async throws {
        // Given
        mockDataFetcher.dataToReturn = [
            load(data: "person")
        ]
        mockDataFetcher.responsesToReturn = [
            URLResponse()
        ]
        
        // When
        let result = await repository.fetch(personId: 21)
        
        // Then
        guard case .success(let person) = result else {
            XCTFail("should have returned a Person")
            return
        }
        XCTAssertEqual(person.id, 2039) // value from fixture, not parameter
        
        XCTAssertEqual(mockDataFetcher.dataForCalledCount, 1)
        XCTAssertEqual(mockDataFetcher.requestsPassed.count, 1)
        XCTAssertEqual(mockDataFetcher.requestsPassed[0].url?.absoluteString, "https://api.themoviedb.org/3/person/21?api_key=my_api_key")
    }
}
