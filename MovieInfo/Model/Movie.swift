//
//  Movie.swift
//  MovieInfo
//
//  Created by Stuart Crook on 24/04/2023.
//

import Foundation

struct Movie {

    let id: Int
    let title: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let runtime: Int
    let tagline: String
    let overview: String
    
    let cast: [SearchResult]
    let crew: [SearchResult]
    
    var releaseYear: String {
        return String(releaseDate.prefix(4))
    }
    
    var runtimeMins: String {
        return "\(runtime) mins"
    }
    
    static func from(details: [String:Any], credits: [String:Any]) -> Movie? {
        guard let id = details["id"] as? Int,
              let title = details["original_title"] as? String,
              let releaseDate = details["release_date"] as? String,
              let runtime = details["runtime"] as? Int,
              let tagline = details["tagline"] as? String,
              let overview = details["overview"] as? String,
              let cast = credits["cast"] as? [[String:Any]],
              let crew = credits["crew"] as? [[String:Any]] else {
            return nil
        }
        return Movie(
            id: id,
            title: title,
            posterPath: details["poster_path"] as? String,
            backdropPath: details["backdrop_path"] as? String,
            releaseDate: releaseDate,
            runtime: runtime,
            tagline: tagline,
            overview: overview,
            cast: cast.compactMap { SearchResult.from(cast: $0) },
            crew: crew.compactMap { SearchResult.from(crew: $0) }
        )
    }
}
