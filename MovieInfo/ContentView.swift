//
//  ContentView.swift
//  MovieInfo
//
//  Created by Stuart Crook on 24/04/2023.
//

import SwiftUI

struct ContentView: View {
    
    let repository: Repository
    
    @State private var searchTerm = ""
    @State private var searchResults = [SearchResult]()
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationStack {
            Text(errorMessage)
            List(searchResults, id: \.self) { result in
                NavigationLink(value: result) {
                    SearchResultView(result: result)
                }
            }
            .listStyle(.plain)
            .overlay(Group {
                if searchResults.isEmpty && !searchTerm.isEmpty {
                    Text("No Results")
                }
            })
            .navigationDestination(for: SearchResult.self) { result in
                
                // Navigation for this app is simple: If a summary item is selected,
                //  we display the details screen for that item

                switch result {
                case .movie(let movie):
                    MovieView(summary: movie, repository: repository)
                case .tvShow(let tvShow):
                    TVShowView(summary: tvShow, repository: repository)
                case .person(let person):
                    PersonView(summary: person, repository: repository)
                }
            }
            .navigationDestination(for: PersonSummary.self) { person in
                PersonView(summary: person, repository: repository)
            }
            .navigationTitle("Search")
        }
        .searchable(text: $searchTerm, prompt: "Movie, TV Show or Actor")
        // Search can be implemented to start either when the "search" key on the
        //  keyboard is tapped (`.onSubmit`) or after a set number of characters have
        //  been input (using `.onChange`). For now we'll choose the former.
        .onSubmit(of: .search) {
            performSearch(seachTerm: searchTerm)
        }
        //.onChange(of: searchTerm) { _ in
        //    if searchTerm.count >= 3 {
        //        performSearch(seachTerm: searchTerm)
        //    }
        //}
        .onChange(of: searchTerm) { term in
            // clear results when search term is cleared
            if term.isEmpty {
                searchResults = []
            }
        }
    }
    
    func performSearch(seachTerm: String) {
        
        searchResults = []
        errorMessage = ""
        
        Task() {
            let result = await repository.search(term: seachTerm)
            switch result {
            case .success(let results):
                searchResults = results
            case .failure(let error):
                errorMessage = error.localizedDescription
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(repository: MockRepository())
    }
}
