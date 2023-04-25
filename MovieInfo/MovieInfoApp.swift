//
//  MovieInfoApp.swift
//  MovieInfo
//
//  Created by Stuart Crook on 24/04/2023.
//

import SwiftUI

@main
struct MovieInfoApp: App {
    var body: some Scene {
        WindowGroup {
            // You will need an API key for The Movie Database API
            //  (see https://developers.themoviedb.org/3/getting-started/introduction)
            ContentView(repository: RepositoryImpl(apiKey: ""))
        }
    }
}
