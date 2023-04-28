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
                // This code is replicated elsewhere and would be terrific if we could
                //  replace it with an injected Coordinator, but that would require that
                //  we were allowed to declare a function in a protocol to return `some View`
                //  as is expected here.
                // Having navigation behaviour inherited from this far up the stack could
                //  also prove troublesome and could prevent useful testing.
                switch result.mediaType {
                case .movie:
                    MovieView(result: result, repository: repository)
                case .tv:
                    TVShowView(result: result, repository: repository)
                case .person:
                    PersonView(result: result, repository: repository)
                }
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
