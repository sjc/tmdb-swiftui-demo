//
//  TVShowView.swift
//  TVShowInfo
//
//  Created by Stuart Crook on 24/04/2023.
//

import SwiftUI

struct TVShowView: View {
    
    let summary: TVShowSummary
    let repository: Repository
    
    @State private var details: TVShowDetails?
    @State private var errorMessage: String?

    var body: some View {
        if let details = details {
            view(forDetails: details, summary: summary)
        } else if let errorMessage = errorMessage {
            Text(errorMessage)
        } else {
            view(forSummary: summary)
                .task {
                    await fetchShow()
                }
        }
    }
    
    func view(forSummary summary: TVShowSummary) -> some View {
        VStack {
            HeroImageView(
                title: summary.name,
                imagePath: summary.backdropPath
            )
            Text(summary.overview)
                .padding()
            Spacer()
            ProgressView()
                .padding(.all)
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func view(forDetails details: TVShowDetails, summary: TVShowSummary) -> some View {
        VStack {
            HeroImageView(
                title: summary.name,
                imagePath: summary.backdropPath
            )
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    HStack {
                        Text(details.activeYears)
                            .font(.caption)
                        Spacer()
                        if let runtimeMins = details.runtimeMins {
                            Text(runtimeMins)
                                .font(.caption)
                        }
                    }
                    .padding([.leading,.trailing])
                    Text("\(details.numberOfSeasons) seasons, \(details.numberOfEpisodes) episodes")
                        .padding()
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
                    Spacer()
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
    
    func fetchShow() async {
        let result = await repository.fetch(tvShowId: summary.id)
        switch result {
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        case .success(let details):
            self.details = details
        }
    }
}

struct TVShowView_Previews: PreviewProvider {
    static var previews: some View {
        let repository = MockRepository()
        TVShowView(
            summary: repository.searchResultsToReturn![1].tvShow!,
            repository: repository
        )
    }
}
