//
//  Credits.swift
//  MovieInfo
//
//  Created by Stuart Crook on 26/06/2023.
//

import Foundation

struct Credits: Decodable {

    // represents the top-level object returned by the /credits endpoints

    let cast: [PersonSummary]
    let crew: [PersonSummary]
}
