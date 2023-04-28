//
//  Repository.swift
//  MovieInfo
//
//  Created by Stuart Crook on 24/04/2023.
//

import Foundation

protocol Repository {
    func search(term: String) async -> Result<[SearchResult],Error>
    func fetch(movieId: Int) async -> Result<Movie,Error>
    func fetch(tvShowId: Int) async -> Result<TVShow,Error>
    func fetch(personId: Int) async -> Result<Person,Error>
}

enum RepositoryError: Error {
    case noData
    case http(statusCode: Int)
    case parseFailed
    case tmdb(code: Int, message: String)
    
    static func from(json: [String:Any]) -> RepositoryError? {
        // TMDB errors are JSON dictionaries with the form:
        //  {
        //      success: false,
        //      status_code: 34,
        //      status_message: "The resource you requested could not be found."
        //  }
        guard let success = json["success"] as? Bool, success == false else {
            return nil
        }
        let code = json["status_code"] as? Int ?? 0
        let message = json["status_message"] as? String ?? ""
        return .tmdb(code: code, message: message)
    }
}
