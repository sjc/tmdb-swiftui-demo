//
//  Person.swift
//  MovieInfo
//
//  Created by Stuart Crook on 24/04/2023.
//

import Foundation

struct PersonSummary: Equatable, Codable {

    // the information about a person which is returned via the search API
    //  where "media_type": "person"

    let id: Int
    let name: String
    let profilePath: String?
    let department: String?
    let character: String?
    let job: String?
    let originalName: String?
    let popularity: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
        case department
        case character
        case job
        case originalName = "original_name"
        case popularity
    }
}

extension PersonSummary: Hashable {
    
}

struct PersonDetails: Codable {

    // the information about aperson returned by the person/<id> API
    //  without duplicates from PersonSummary

    let id: Int
    let alsoKnownAs: [String]
    let biography: String
    let birthday: String?
    let deathday: String?
    let placeOfBirth: String?
    let imdbId: String?

    // TODO: further details pulled from other API endpoints

    enum CodingKeys: String, CodingKey {
        case id
        case alsoKnownAs = "also_known_as"
        case biography
        case birthday
        case deathday
        case placeOfBirth = "place_of_birth"
        case imdbId = "imdb_id"
        
    }

    var dates: String {
        return "\(String((birthday ?? "?").prefix(4))) - \(String((deathday ?? "").prefix(4)))"
    }
}
