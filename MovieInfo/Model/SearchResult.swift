//
//  SearchResult.swift
//  MovieInfo
//
//  Created by Stuart Crook on 24/04/2023.
//

import Foundation

enum SearchResult: Decodable, Identifiable {

    case person(_: PersonSummary)
    case movie(_: MovieSummary)
    case tvShow(_: TVShowSummary)

    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
    }

    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let mediaType: MediaType? = try? container.decodeIfPresent(MediaType.self, forKey: .mediaType)

        switch mediaType {
        case .person:
            self = .person(try PersonSummary(from: decoder))
        case .movie:
            self = .movie(try MovieSummary(from: decoder))
        case .tv:
            self = .tvShow(try TVShowSummary(from: decoder))
        case .none:
            fatalError()
        }
    }
    
    var id: Int {
        switch self {
        case .person(let person):
            return person.id
        case .movie(let movie):
            return movie.id
        case .tvShow(let tvShow):
            return tvShow.id
        }
    }

    var popularity: Double {
        switch self {
        case .person(let person):
            return person.popularity ?? 0.0
        case .movie(let movie):
            return movie.popularity
        case .tvShow(let tvShow):
            return tvShow.popularity
        }
    }
    
    var movie: MovieSummary? {
        if case .movie(let movie) = self {
            return movie
        }
        return nil
    }
    
    var tvShow: TVShowSummary? {
        if case .tvShow(let tvShow) = self {
            return tvShow
        }
        return nil
    }
    
    var person: PersonSummary? {
        if case .person(let person) = self {
            return person
        }
        return nil
    }
}

extension SearchResult {
    
    var smallImageURL: URL? {
        switch self {
        case .person(let person):
            return person.profilePath?.smallImageURL
        case .movie(let movie):
            return movie.posterPath?.smallImageURL
        case .tvShow(let tvShow):
            return tvShow.posterPath?.smallImageURL
        }
    }
    
    var title: String {
        switch self {
        case .person(let person):
            return person.name
        case .movie(let movie):
            return movie.title
        case .tvShow(let tvShow):
            return tvShow.name
        }
    }
    
    var subtitle: String {
        switch self {
        case .person(let person):
            return person.department ?? ""
        case .movie(let movie):
            return movie.releaseYear
        case .tvShow(let tvShow):
            return String((tvShow.firstAirDate ?? "").prefix(4))
        }
    }
}

extension SearchResult: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}
