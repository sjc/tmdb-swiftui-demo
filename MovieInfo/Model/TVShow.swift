//
//  TVShow.swift
//  MovieInfo
//
//  Created by Stuart Crook on 24/04/2023.
//

import Foundation

struct TVShowSummary: Equatable, Codable {
    
    // the information about a TV show which is returned by the Search API
    //  where "media_type": "tv",
    
    let id: Int
    let name: String
    let backdropPath: String?
    let posterPath: String?
    let firstAirDate: String?
    let genres: [Int] // TODO: parse these to values
    let countryOfOrigin: [String]
    let originalLanguage: String
    let originalName: String?
    let overview: String
    let popularity: Double
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case genres = "genre_ids"
        case countryOfOrigin = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case popularity
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct TVShowDetails: Decodable {
    
    let id: Int
    let tagline: String?
    let createdBy: [PersonSummary]
    let numberOfEpisodes: Int
    let numberOfSeasons: Int
    let episodeRunTimes: [Int]
    let firstAirDate: String? // duplicated from summary
    let lastAirDate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case tagline
        case createdBy = "created_by"
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case episodeRunTimes = "episode_run_time"
        case firstAirDate = "first_air_date"
        case lastAirDate = "last_air_date"
    }

    var activeYears: String {
        return "\((firstAirDate ?? "?").prefix(4)) - \((lastAirDate ?? "").prefix(4))"
    }

    var runtimeMins: String? {
        if let runtime = episodeRunTimes.first {
            return "\(runtime) mins"
        }
        return nil
    }

    var cast: [PersonSummary]?
    var crew: [PersonSummary]?

    mutating func add(credits: Credits) {
        self.cast = credits.cast
        self.crew = credits.crew
    }
}
