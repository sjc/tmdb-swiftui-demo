//
//  PersonView.swift
//  MovieInfo
//
//  Created by Stuart Crook on 24/04/2023.
//

import SwiftUI

struct PersonView: View {
    
    let summary: PersonSummary
    let repository: Repository
    
    @State private var details: PersonDetails?
    @State private var errorMessage: String?

    var body: some View {
        if let details = details {
            view(forDetails: details, summary: summary)
        } else if let errorMessage = errorMessage {
            Text(errorMessage)
        } else {
            view(forSummary: summary)
                .task {
                    await fetchPerson()
                }
        }
    }
    
    func view(forSummary summary: PersonSummary) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                headerView(
                    imagePath: summary.profilePath,
                    name: summary.name
                )
                Spacer()
                ProgressView()
                    .padding(.all)
                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func view(forDetails details: PersonDetails, summary: PersonSummary) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                headerView(
                    imagePath: summary.profilePath,
                    name: summary.name,
                    dates: details.dates,
                    place: details.placeOfBirth
                )
                Text(details.biography)
                    .padding(.top)
                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func headerView(imagePath: String?, name: String, dates: String = "", place: String? = nil) -> some View {
        HStack {
            AsyncImage(url: imagePath?.smallImageURL) { phase in
                switch phase {
                case .empty:
                    if summary.profilePath?.smallImageURL == nil {
                        EmptyView()
                    } else {
                        ProgressView()
                            .tint(Color.white)
                    }
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 200, maxHeight: 300)
                case .failure:
                    EmptyView()
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 200, height: 300)
            .background(Color.gray)
            .cornerRadius(2.0)
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title)
                Text(dates)
                if let place = place {
                    Text(place)
                }
            }
            .padding(.leading)
        }
    }
    
    func fetchPerson() async {
        let result = await repository.fetch(personId: summary.id)
        switch result {
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        case .success(let details):
            self.details = details
        }
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        let repository = MockRepository()
        PersonView(
            summary: repository.searchResultsToReturn![2].person!,
            repository: repository
        )
    }
}
