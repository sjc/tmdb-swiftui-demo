//
//  SearchResult.swift
//  MovieInfo
//
//  Created by Stuart Crook on 24/04/2023.
//

import Foundation

struct SearchResult {
    let mediaType: MediaType
    let id: Int
    let popularity: Double
    let title: String
    let subtitle: String
    let posterPath: String?
    let backgroundPath: String?
    
    //
    // MARK: Parsing from /search/multi response
    //
    
    static func from(json: [String:Any]) -> SearchResult? {
        guard let type = json["media_type"] as? String, let mediaType = MediaType(rawValue: type) else {
            return nil
        }
        switch mediaType {
        case .movie:
            return from(movie: json)
        case .tv:
            return from(tvShow: json)
        case .person:
            return from(person: json)
        }
    }
    
    private static func from(movie json: [String:Any]) -> SearchResult? {
        guard let id = json["id"] as? Int,
              let popularity = json["popularity"] as? Double,
              let title = json["title"] as? String else {
            return nil
        }
        return SearchResult(
            mediaType: .movie,
            id: id,
            popularity: popularity,
            title: title,
            subtitle: String((json["release_date"] as? String ?? "").prefix(4)),
            posterPath: json["poster_path"] as? String,
            backgroundPath: json["backdrop_path"] as? String
        )
    }
    
    private static func from(tvShow json: [String:Any]) -> SearchResult? {
        guard let id = json["id"] as? Int,
              let popularity = json["popularity"] as? Double,
              let title = json["name"] as? String else {
            return nil
        }
        return SearchResult(
            mediaType: .tv,
            id: id,
            popularity: popularity,
            title: title,
            subtitle: String((json["first_air_date"] as? String ?? "").prefix(4)),
            posterPath: json["poster_path"] as? String,
            backgroundPath: json["backdrop_path"] as? String
        )
    }

    private static func from(person json: [String:Any]) -> SearchResult? {
        guard let id = json["id"] as? Int,
              let popularity = json["popularity"] as? Double,
              let title = json["name"] as? String else {
            return nil
        }
        return SearchResult(
            mediaType: .person,
            id: id,
            popularity: popularity,
            title: title,
            subtitle: json["known_for_department"] as? String ?? "", // this will be wrong (eg. "Acting" rather than "Actor") but we'll go with it for now
            posterPath: json["profile_path"] as? String,
            backgroundPath: nil
        )
    }
    
    //
    // MARK: Parsing from /credits response
    //
    
    static func from(cast json: [String:Any]) -> SearchResult? {
        guard let id = json["id"] as? Int,
              let popularity = json["popularity"] as? Double,
              let name = json["name"] as? String else {
            return nil
        }
        return SearchResult(
            mediaType: .person,
            id: id,
            popularity: popularity,
            title: name,
            subtitle: json["character"] as? String ?? "",
            posterPath: json["profile_path"] as? String,
            backgroundPath: nil
        )
    }
    
    static func from(crew json: [String:Any]) -> SearchResult? {
        guard let id = json["id"] as? Int,
              let popularity = json["popularity"] as? Double,
              let name = json["name"] as? String else {
            return nil
        }
        return SearchResult(
            mediaType: .person,
            id: id,
            popularity: popularity,
            title: name,
            subtitle: json["job"] as? String ?? "",
            posterPath: json["profile_path"] as? String,
            backgroundPath: nil
        )
    }
}

extension SearchResult: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
