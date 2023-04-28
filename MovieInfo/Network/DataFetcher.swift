//
//  DataFetcher.swift
//  MovieInfo
//
//  Created by Stuart Crook on 28/04/2023.
//

import Foundation

protocol DataFetcher {
    // This is the signature for the URLSession func...
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

extension URLSession: DataFetcher {
    // ...so we can add conformance to URLSession without having to implement anything
}
