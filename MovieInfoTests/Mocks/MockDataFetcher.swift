//
//  MockDataFetcher.swift
//  MovieInfo
//
//  Created by Stuart Crook on 28/04/2023.
//

import Foundation
@testable import MovieInfo

class MockDataFetcher: DataFetcher {
    
    var dataForCalledCount = 0
    var requestsPassed = [URLRequest]()
    
    var dataToReturn = [Data]()
    var responsesToReturn = [URLResponse]()
    
    var errorToThrow: Error?
    
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        
        dataForCalledCount += 1
        requestsPassed.append(request)
        
        if let error = errorToThrow {
            throw error
        }
        
        assert(dataToReturn.count >= dataForCalledCount)
        assert(responsesToReturn.count >= dataForCalledCount)
        
        let index = dataForCalledCount - 1
        return (dataToReturn[index],responsesToReturn[index])
    }
}
