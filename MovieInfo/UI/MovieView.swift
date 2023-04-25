//
//  MovieView.swift
//  MovieInfo
//
//  Created by Stuart Crook on 24/04/2023.
//

import SwiftUI

struct MovieView: View {
    
    let result: SearchResult
    let repository: Repository
    
    @State private var movie: Movie?
    @State private var errorMessage: String?

    var body: some View {
        if let movie = movie {
            view(forMovie: movie)
        } else if let errorMessage = errorMessage {
            Text(errorMessage)
        } else {
            view(forSearchResult: result)
                .task {
                    await fetchMovie()
                }
        }
    }
    
    func view(forSearchResult: SearchResult) -> some View {
        VStack {
            HeroImageView(title: result.title, imagePath: result.backgroundPath)
            Spacer()
            ProgressView()
                .padding(.all)
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func view(forMovie movie: Movie) -> some View {
        VStack {
            HeroImageView(title: movie.title, imagePath: movie.backdropPath)
            List() {
                VStack {
                    HStack {
                        Text(movie.releaseYear)
                        Spacer()
                        Text(movie.runtimeMins)
                    }
                    Text(movie.tagline)
                        .padding(.all)
                    Text(movie.overview)
                }
                creditsSection(title: "Cast", members: movie.cast)
                creditsSection(title: "Crew", members: movie.crew)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func creditsSection(title: String, members: [SearchResult]) -> some View {
        return Section(header: Text(title)) {
            ForEach(members, id: \.self) { member in
                NavigationLink(value: member) {
                    VStack(alignment: .leading) {
                        Text(member.title)
                        Text(member.subtitle)
                    }
                }
            }
        }
    }
    
    func fetchMovie() async {
        let result = await repository.fetch(movieId: result.id)
        switch result {
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        case .success(let movie):
            self.movie = movie
        }
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        let repository = MockRepository()
        MovieView(
            result: repository.searchResultsToReturn![0],
            repository: repository
        )
    }
}
