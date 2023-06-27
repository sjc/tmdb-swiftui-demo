//
//  RepositoryImpl.swift
//  MovieInfo
//
//  Created by Stuart Crook on 24/04/2023.
//

import Foundation

class RepositoryImpl: Repository {

    init(apiKey: String, dataFetcher: DataFetcher = URLSession.shared) {
        self.apiKey = apiKey
        self.dataFetcher = dataFetcher
    }

    let apiKey: String
    let dataFetcher: DataFetcher

    func search(term: String) async -> Result<[SearchResult], Error> {
        do {
            let data = try await fetchData(endpoint: .search(term: term))
            guard let results = try? JSONDecoder().decode(SearchResults.self, from: data) else {
                return .failure(RepositoryError.parseFailed)
            }
            return .success(results.results.sorted(by: { $0.popularity > $1.popularity }))

        } catch {
            return .failure(error)
        }
    }
    
    func fetch(movieId: Int) async -> Result<MovieDetails, Error> {
        do {
            let detailsData = try await fetchData(endpoint: .movies(id: movieId))
            guard var details = try? JSONDecoder().decode(MovieDetails.self, from: detailsData) else {
                return .failure(RepositoryError.parseFailed)
            }
            let creditsData = try await fetchData(endpoint: .movieCredits(id: movieId))
            guard let credits = try? JSONDecoder().decode(Credits.self, from: creditsData) else {
                return .failure(RepositoryError.parseFailed)
            }
            details.add(credits: credits)
            return .success(details)
        } catch {
            return .failure(error)
        }
    }

    func fetch(tvShowId: Int) async -> Result<TVShowDetails, Error> {
        do {
            let detailsData = try await fetchData(endpoint: .tvShows(id: tvShowId))
            guard var details = try? JSONDecoder().decode(TVShowDetails.self, from: detailsData) else {
                return .failure(RepositoryError.parseFailed)
            }
            let creditsData = try await fetchData(endpoint: .tvShowCredits(id: tvShowId))
            guard let credits = try? JSONDecoder().decode(Credits.self, from: creditsData) else {
                return .failure(RepositoryError.parseFailed)
            }
            details.add(credits: credits)
            return .success(details)
        } catch {
            return .failure(error)
        }
    }

    func fetch(personId: Int) async -> Result<PersonDetails, Error> {
        do {
            let data = try await fetchData(endpoint: .person(id: personId))
            guard let details = try? JSONDecoder().decode(PersonDetails.self, from: data) else {
                return .failure(RepositoryError.parseFailed)
            }
            return .success(details)
        } catch {
            return .failure(error)
        }
    }

    private func fetchData(endpoint: Endpoint) async throws -> Data {
        let request = endpoint.request(with: apiKey)
        let (data,_) = try await dataFetcher.data(for: request, delegate: nil)
        // TODO: get NSURLResponse from above and examine the status code
        if data.isEmpty {
            throw RepositoryError.noData
        }
        if let error = RepositoryError.from(data: data) {
            throw error
        }
        return data
    }
}
