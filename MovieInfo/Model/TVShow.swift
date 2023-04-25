//
//  TVShow.swift
//  MovieInfo
//
//  Created by Stuart Crook on 24/04/2023.
//

import Foundation

struct TVShow {
    
    let id: Int
    let title: String
    let posterPath: String?
    let backdropPath: String?
    let startDate: String
    let endDate: String
    let seasons: Int
    let runtime: Int
    let tagline: String
    let overview: String
    
    let cast: [SearchResult]
    let crew: [SearchResult]
    
    var activeYears: String {
        return "\(String(startDate.prefix(4))) - \(String(endDate.prefix(4)))"
    }
    
    var runtimeMins: String {
        return "\(runtime) mins"
    }
    
    static func from(details: [String:Any], credits: [String:Any]) -> TVShow? {
        guard let id = details["id"] as? Int,
              let title = details["name"] as? String,
              let startDate = details["first_air_date"] as? String,
              let runtimes = details["episode_run_time"] as? [Int],
              let seasons = details["seasons"] as? [[String:Any]],
              let tagline = details["tagline"] as? String,
              let overview = details["overview"] as? String,
              let cast = credits["cast"] as? [[String:Any]],
              let crew = credits["crew"] as? [[String:Any]] else {
            return nil
        }
        return TVShow(
            id: id,
            title: title,
            posterPath: details["poster_path"] as? String,
            backdropPath: details["backdrop_path"] as? String,
            startDate: startDate,
            endDate: details["last_air_date"] as? String ?? "",
            seasons: seasons.count,
            runtime: runtimes.first ?? 0,
            tagline: tagline,
            overview: overview,
            cast: cast.compactMap { SearchResult.from(cast: $0) },
            crew: crew.compactMap { SearchResult.from(crew: $0) }
        )
    }
}
