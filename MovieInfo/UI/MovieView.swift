//
//  MovieView.swift
//  MovieInfo
//
//  Created by Stuart Crook on 24/04/2023.
//

import SwiftUI

struct MovieView: View {

    let summary: MovieSummary
    let repository: Repository

    @State private var details: MovieDetails?
    @State private var errorMessage: String?

    var body: some View {
        if let details = details {
            view(forDetails: details, summary: summary)
        } else if let errorMessage = errorMessage {
            Text(errorMessage)
        } else {
            view(forSummary: summary)
                .task {
                    await fetchMovie()
                }
        }
    }

    func view(forSummary summary: MovieSummary) -> some View {
        VStack {
            HeroImageView(
                title: summary.title,
                imagePath: summary.backdropPath
            )
            ScrollView {
                Text(summary.overview)
                Spacer()
                ProgressView()
                    .padding(.all)
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(edges: .top)
    }
    
    func view(forDetails details: MovieDetails, summary: MovieSummary) -> some View {
        VStack {
            HeroImageView(
                title: summary.title,
                imagePath: summary.backdropPath
            )
            ScrollView {
                VStack {
                    HStack {
                        Text(summary.releaseYear)
                            .font(.caption)
                        Spacer()
                        if details.runtime != 0 {
                            Text("\(details.runtime) mins")
                                .font(.caption)
                        }
                    }
                    .padding([.leading,.trailing,.bottom])
                    if let tagline = details.tagline, !tagline.isEmpty {
                        Text(tagline)
                            .italic()
                            .padding(.bottom)
                    }
                    Text(summary.overview)
                        .padding()
                    if let cast = details.cast {
                        creditsSection(title: "Cast", members: cast)
                    }
                    if let crew = details.crew {
                        creditsSection(title: "Crew", members: crew)
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(edges: .top)
    }
    
    func creditsSection(title: String, members: [PersonSummary]) -> some View {
        return VStack(alignment: .leading) {
            Text(title)
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(members, id: \.self) { person in
                        NavigationLink(value: person) {
                            PersonSummaryView(summary: person)
                                .padding([.leading,.trailing])
                        }
                    }
                }
            }
        }
    }
    
    func fetchMovie() async {
        let result = await repository.fetch(movieId: summary.id)
        switch result {
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        case .success(let details):
            self.details = details
        }
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        let repository = MockRepository()
        MovieView(
            summary: repository.searchResultsToReturn![0].movie!,
            repository: repository
        )
    }
}
