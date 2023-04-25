//
//  ImageURL.swift
//  MovieInfo
//
//  Created by Stuart Crook on 25/04/2023.
//

import Foundation

extension String {
    var smallImageURL: URL? {
        return imageURL(width: 500)
    }
    
    var largeImageURL: URL? {
        return imageURL(width: 1280)
    }
    
    func imageURL(width: Int) -> URL? {
        var url = URLComponents(string: "https://image.tmdb.org")!
        url.path = "/t/p/w\(width)" + self
        return url.url
    }
}
