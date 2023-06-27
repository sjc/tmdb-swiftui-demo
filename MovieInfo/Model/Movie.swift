//
//  Movie.swift
//  MovieInfo
//
//  Created by Stuart Crook on 24/04/2023.
//

import Foundation

struct MovieSummary: Equatable, Codable {

    // the information about a movie which is returned by the Search API
    //  where "media_type": "movie"

    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let genres: [Int]
    let originalLanguage: String?
    let originalTitle: String?
    let popularity: Double
    let releaseDate: String?
    let video: Bool // TODO: what is this for?
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case overview
        case genres = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    var releaseYear: String {
        return String((releaseDate ?? "").prefix(4))
    }
}

struct MovieDetails: Codable {

    let id: Int
    let tagline: String?
    let runtime: Int
    let budget: Int?
    let revenue: Int?
    let imdbId: String?

    enum CodingKeys: String, CodingKey {
        case id
        case tagline
        case runtime
        case budget
        case revenue
        case imdbId = "imdb_id"
    }

    var cast: [PersonSummary]?
    var crew: [PersonSummary]?
    
    mutating func add(credits: Credits) {
        self.cast = credits.cast
        self.crew = credits.crew
    }
}
