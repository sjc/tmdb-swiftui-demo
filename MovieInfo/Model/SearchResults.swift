//
//  SearchResults.swift
//  MovieInfo
//
//  Created by Stuart Crook on 26/06/2023.
//

import Foundation

struct SearchResults: Decodable {
    
    // represents the top-level JSON object returned by the Search API

    let results: [SearchResult]
}
