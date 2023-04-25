//
//  Person.swift
//  MovieInfo
//
//  Created by Stuart Crook on 24/04/2023.
//

import Foundation

struct Person {

    let id: Int
    let name: String
    let birthday: String
    let deathday: String
    let placeOfBirth: String
    let biography: String
    let posterPath: String?
    
    var dates: String {
        return "\(String(birthday.prefix(4))) - \(String(deathday.prefix(4)))"
    }
    
    static func from(json: [String:Any]) -> Person? {
        guard let id = json["id"] as? Int,
              let name = json["name"] as? String else {
            return nil
        }
        return Person(
            id: id,
            name: name,
            birthday: json["birthday"] as? String ?? "",
            deathday: json["deathday"] as? String ?? "",
            placeOfBirth: json["place_of_birth"] as? String ?? "",
            biography: json["biography"] as? String ?? "",
            posterPath: json["profile_path"] as? String
        )
    }
}
