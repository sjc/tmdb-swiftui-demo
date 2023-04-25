//
//  RepositoryImpl.swift
//  MovieInfo
//
//  Created by Stuart Crook on 24/04/2023.
//

import Foundation

// https://api.themoviedb.org/3/

enum Endpoint {
    case search(term: String) // search/multi
    case movies(id: Int) // movie/{id}
    case movieCredits(id: Int) // movie/{id}/credits
    case tvShows(id: Int) // tv/{id}
    case tvShowCredits(id: Int) // tv/{id}/credits
    case people(id: Int) // person/{id}
    
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
        case .people(let id):
            return "/3/person/\(id)"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .search(let term):
            return [
                URLQueryItem(name: "query", value: term),
                URLQueryItem(name: "include_adult", value: "false") // because that would be embaressing
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

class RepositoryImpl: Repository {
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    let apiKey: String
    
    func search(term: String) async -> Result<[SearchResult], Error> {
        do {
            let json = try await fetchJson(endpoint: .search(term: term))
            guard let results = json["results"] as? [[String:Any]] else {
                return .success([]) // indicates nothing went wrong, but we got no results
            }
            return .success(results.compactMap { SearchResult.from(json:$0) }.sorted(by: { $0.popularity > $1.popularity }))

        } catch {
            return .failure(error)
        }
    }
    
    func fetch(movieId: Int) async -> Result<Movie, Error> {
        do {
            let details = try await fetchJson(endpoint: .movies(id: movieId))
            let credits = try await fetchJson(endpoint: .movieCredits(id: movieId))
            guard let movie = Movie.from(details: details, credits: credits) else {
                return .failure(RepositoryError.parseFailed)
            }
            return .success(movie)
        } catch {
            return .failure(error)
        }
    }

    func fetch(tvShowId: Int) async -> Result<TVShow, Error> {
        do {
            let details = try await fetchJson(endpoint: .tvShows(id: tvShowId))
            let credits = try await fetchJson(endpoint: .tvShowCredits(id: tvShowId))
            guard let tvShow = TVShow.from(details: details, credits: credits) else {
                return .failure(RepositoryError.parseFailed)
            }
            return .success(tvShow)
        } catch {
            return .failure(error)
        }
    }

    func fetch(personId: Int) async -> Result<Person, Error> {
        do {
            let json = try await fetchJson(endpoint: .people(id: personId))
            guard let person = Person.from(json: json) else {
                return .failure(RepositoryError.parseFailed)
            }
            return .success(person)
        } catch {
            return .failure(error)
        }
    }

    private func fetchJson(endpoint: Endpoint) async throws -> [String:Any] {
        let request = endpoint.request(with: apiKey)
        let (data,_) = try await URLSession.shared.data(for: request)
        // TODO: get NSURLResponse from above and examine the status code
        if data.isEmpty {
            throw RepositoryError.noData
        }
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String:Any] else {
            throw RepositoryError.parseFailed
        }
        if let error = RepositoryError.from(json: json) {
            throw error
        }
        return json
    }
}
