//
//  MockRespository.swift
//  MovieInfo
//
//  Created by Stuart Crook on 25/04/2023.
//

import Foundation

// Usually mocks would exist only in the Tests bundle, but here they are in the main bundle so they
//  can be used to provide data to the SwiftUI previews

class MockRepository: Repository {
    
    var searchResultsToReturn: [SearchResult]? = [
        SearchResult(
            mediaType: .movie,
            id: 8321,
            popularity: 1.0,
            title: "In Bruges",
            subtitle: "2008",
            posterPath: "/jMiBBqk72VRo1Y39x2ZbbenEU3a.jpg",
            backgroundPath: "/dtGxDOcFssdUUTYBr6M6INXTI1e.jpg"
        ),
        SearchResult(
            mediaType: .tv,
            id: 95,
            popularity: 1.0,
            title: "Buffy the Vampire Slayer",
            subtitle: "1997",
            posterPath: "/y7fVZkyheCEQHDUEHwNmYENGfT2.jpg",
            backgroundPath: "/q4CbisNArigphVn608Faxijdw8N.jpg"
        ),
        SearchResult(
            mediaType: .person,
            id: 2039,
            popularity: 1.0,
            title: "Brendan Gleeson",
            subtitle: "Acting",
            posterPath: "/379TXtBPRrkBDrEBWPQ5v3up7kT.jpg",
            backgroundPath: nil
        )
    ]
    
    var searchErrorToReturn: Error?
    
    func search(term: String) async -> Result<[SearchResult], Error> {
        if let results = searchResultsToReturn {
            return .success(results)
        } else if let error = searchErrorToReturn {
            return .failure(error)
        }
        return .failure(RepositoryError.noData)
    }
    
    var movieToReturn: Movie? = Movie(
        id: 8321,
        title: "In Bruges",
        posterPath: "/jMiBBqk72VRo1Y39x2ZbbenEU3a.jpg",
        backdropPath: "/dtGxDOcFssdUUTYBr6M6INXTI1e.jpg",
        releaseDate: "2008-02-08",
        runtime: 108,
        tagline: "Shoot first. Sightsee later.",
        overview: "Ray and Ken, two hit men, are in Bruges, Belgium, waiting for their next mission. While they are there they have time to think and discuss their previous assignment. When the mission is revealed to Ken, it is not what he expected.",
        cast: [],
        crew: []
    )
    
    var movieErrorToReturn: Error?
    
    func fetch(movieId: Int) async -> Result<Movie, Error> {
        if let movie = movieToReturn {
            return .success(movie)
        } else if let error = movieErrorToReturn {
            return .failure(error)
        }
        return .failure(RepositoryError.noData)
    }
    
    var tvShowToReturn: TVShow? = TVShow(
        id: 95,
        title: "Buffy the Vampire Slayer",
        posterPath: "/y7fVZkyheCEQHDUEHwNmYENGfT2.jpg",
        backdropPath: "/q4CbisNArigphVn608Faxijdw8N.jpg",
        startDate: "1997-03-10",
        endDate: "2003-05-20",
        seasons: 8,
        runtime: 43,
        tagline: "Get home before dark.",
        overview: "Into every generation a slayer is born: one girl in all the world, a chosen one. She alone will wield the strength and skill to fight the vampires, demons, and the forces of darkness; to stop the spread of their evil and the swell of their number. She is the Slayer.",
        cast: [],
        crew: []
    )

    var tvShowErrorToReturn: Error?
    
    func fetch(tvShowId: Int) async -> Result<TVShow, Error> {
        if let tvShow = tvShowToReturn {
            return .success(tvShow)
        } else if let error = tvShowErrorToReturn {
            return .failure(error)
        }
        return .failure(RepositoryError.noData)
    }
    
    var personToReturn: Person? = Person(
        id: 2039,
        name: "Brendan Gleeson",
        birthday: "1955-03-29",
        deathday: "",
        placeOfBirth: "Dublin, Ireland",
        biography: "Brendan Gleeson (born 29 March 1955) is an Irish actor and film director.",
        posterPath: "/379TXtBPRrkBDrEBWPQ5v3up7kT.jpg"
    )

    var personErrorToReturn: Error?
    
    func fetch(personId: Int) async -> Result<Person, Error> {
        if let person = personToReturn {
            return .success(person)
        } else if let error = personErrorToReturn {
            return .failure(error)
        }
        return .failure(RepositoryError.noData)
    }
    
}
