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
        .movie(
            MovieSummary(
                id: 8321,
                title: "In Bruges",
                backdropPath: "/dtGxDOcFssdUUTYBr6M6INXTI1e.jpg",
                posterPath: "/jMiBBqk72VRo1Y39x2ZbbenEU3a.jpg",
                overview: "Stuff",
                genres: [21],
                originalLanguage: nil,
                originalTitle: nil,
                popularity: 1.0,
                releaseDate: "2008",
                video: false,
                voteAverage: 0.0,
                voteCount: 0
            )
        ),
        .tvShow(
            TVShowSummary(
                id: 95,
                name: "Buffy the Vampire Slayer",
                backdropPath: "/q4CbisNArigphVn608Faxijdw8N.jpg",
                posterPath: "/y7fVZkyheCEQHDUEHwNmYENGfT2.jpg",
                firstAirDate: "1997",
                genres: [21],
                countryOfOrigin: ["US"],
                originalLanguage: "en",
                originalName: nil,
                overview: "Into every generation a slayer is born: one girl in all the world, a chosen one. She alone will wield the strength and skill to fight the vampires, demons, and the forces of darkness; to stop the spread of their evil and the swell of their number. She is the Slayer.",
                popularity: 1.0,
                voteAverage: 0.0,
                voteCount: 0
            )
        ),
        .person(
            PersonSummary(
                id: 2039,
                name: "Brendan Gleeson",
                profilePath: "/379TXtBPRrkBDrEBWPQ5v3up7kT.jpg",
                department: "Acting",
                character: nil,
                job: nil,
                originalName: nil,
                popularity: 1.0
            )
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
    
    var movieDetailsToReturn: MovieDetails? = MovieDetails(
        id: 8321,
        tagline: "Shoot first. Sightsee later.",
        runtime: 108,
        budget: nil,
        revenue: nil,
        imdbId: nil
    )
    
    var movieErrorToReturn: Error?
    
    func fetch(movieId: Int) async -> Result<MovieDetails, Error> {
        if let details = movieDetailsToReturn {
            return .success(details)
        } else if let error = movieErrorToReturn {
            return .failure(error)
        }
        return .failure(RepositoryError.noData)
    }
    
    var tvShowDetailsToReturn: TVShowDetails? = TVShowDetails(
        id: 95,
        tagline: "Get home before dark.",
        createdBy: [],
        numberOfEpisodes: 144,
        numberOfSeasons: 7,
        episodeRunTimes: [43],
        firstAirDate: "1997-03-10",
        lastAirDate: "2003-05-20"
    )

    var tvShowErrorToReturn: Error?
    
    func fetch(tvShowId: Int) async -> Result<TVShowDetails, Error> {
        if let details = tvShowDetailsToReturn {
            return .success(details)
        } else if let error = tvShowErrorToReturn {
            return .failure(error)
        }
        return .failure(RepositoryError.noData)
    }
    
    var personDetailsToReturn: PersonDetails? = PersonDetails(
        id: 2039,
        alsoKnownAs: [],
        biography: "Brendan Gleeson (born 29 March 1955) is an Irish actor and film director.",
        birthday: "1955-03-29",
        deathday: nil,
        placeOfBirth: "Dublin, Ireland",
        imdbId: nil
    )

    var personErrorToReturn: Error?
    
    func fetch(personId: Int) async -> Result<PersonDetails, Error> {
        if let details = personDetailsToReturn {
            return .success(details)
        } else if let error = personErrorToReturn {
            return .failure(error)
        }
        return .failure(RepositoryError.noData)
    }
    
}
