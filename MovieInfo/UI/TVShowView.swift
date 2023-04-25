//
//  TVShowView.swift
//  TVShowInfo
//
//  Created by Stuart Crook on 24/04/2023.
//

import SwiftUI

struct TVShowView: View {
    
    let result: SearchResult
    let repository: Repository
    
    @State private var tvShow: TVShow?
    @State private var errorMessage: String?

    var body: some View {
        if let tvShow = tvShow {
            view(forShow: tvShow)
        } else if let errorMessage = errorMessage {
            Text(errorMessage)
        } else {
            view(forSearchResult: result)
                .task {
                    await fetchShow()
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
    
    func view(forShow tvShow: TVShow) -> some View {
        VStack {
            HeroImageView(title: tvShow.title, imagePath: tvShow.backdropPath)
            List() {
                VStack {
                    HStack {
                        Text(tvShow.activeYears)
                        Spacer()
                        Text(tvShow.runtimeMins)
                    }
                    Text("\(tvShow.seasons) seasons")
                        .padding(.all)
                    if !tvShow.tagline.isEmpty {
                        Text(tvShow.tagline)
                            .padding(.bottom)
                    }
                    Text(tvShow.overview)
                }
                creditsSection(title: "Cast", members: tvShow.cast)
                creditsSection(title: "Crew", members: tvShow.crew)
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
    
    func fetchShow() async {
        let result = await repository.fetch(tvShowId: result.id)
        switch result {
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        case .success(let tvShow):
            self.tvShow = tvShow
        }
    }
}

struct TVShowView_Previews: PreviewProvider {
    static var previews: some View {
        let repository = MockRepository()
        TVShowView(
            result: repository.searchResultsToReturn![1],
            repository: repository
        )
    }
}
