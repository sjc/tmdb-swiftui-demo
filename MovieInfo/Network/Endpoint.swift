//
//  Endpoint.swift
//  MovieInfo
//
//  Created by Stuart Crook on 28/04/2023.
//

import Foundation

enum Endpoint {
    case search(term: String) // search/multi
    case movies(id: Int) // movie/{id}
    case movieCredits(id: Int) // movie/{id}/credits
    case tvShows(id: Int) // tv/{id}
    case tvShowCredits(id: Int) // tv/{id}/credits
    case person(id: Int) // person/{id}
    
    var path: String {
        switch self {
        case .search:
            return "/3/search/multi"
        case .movies(let id):
            return "/3/movie/\(id)"
        case .movieCredits(let id):
            return "/3/movie/\(id)/credits"
        case .tvShows(let id):
            return "/3/tv/\(id)"
        case .tvShowCredits(let id):
            return "/3/tv/\(id)/credits"
        case .person(let id):
            return "/3/person/\(id)"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .search(let term):
            return [
                URLQueryItem(name: "query", value: term),
                URLQueryItem(name: "include_adult", value: "false") // because that would be embarrassing
            ]
        default:
            return []
        }
    }

    func request(with apiKey: String) -> URLRequest {
        var url = URLComponents(string: "https://api.themoviedb.org")!
        url.path = self.path
        var parameters = self.parameters
        parameters.append(URLQueryItem(name: "api_key", value: apiKey))
        url.queryItems = parameters
        return URLRequest(url: url.url!)
    }
}
