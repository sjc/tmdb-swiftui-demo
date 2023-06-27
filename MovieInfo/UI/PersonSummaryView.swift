//
//  PersonSummaryView.swift
//  MovieInfo
//
//  Created by Stuart Crook on 26/6/2023.
//

import SwiftUI

struct PersonSummaryView: View {
    
    let summary: PersonSummary
    
    var body: some View {
        VStack {
            AsyncImage(url: summary.profilePath?.smallImageURL) { phase in
                switch phase {
                case .empty:
                    // AsyncImage is okay with a nil URL, but it uses the same
                    //  `.empty` state for it as initial loading, so we need to
                    //  check whether it is trying to load or not
                    if summary.profilePath?.smallImageURL == nil {
                        EmptyView()
                    } else {
                        ProgressView()
                            .tint(Color.white)
                    }
                case .success(let image):
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: 100, maxHeight: 150)
                case .failure:
                    EmptyView()
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 100, height: 150)
            .background(Color.gray)
            .cornerRadius(2.0)
            Text(summary.name)
                .font(.caption)
                .bold()
            if let character = summary.character {
                Text(character)
                    .font(.caption)
            } else if let job = summary.job {
                Text(job)
                    .font(.caption)
            }
        }
    }
}

struct PersonSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        PersonSummaryView(
            summary: PersonSummary(
                id: 2039,
                name: "Brendan Gleeson",
                profilePath: "/379TXtBPRrkBDrEBWPQ5v3up7kT.jpg",
                department: "Acting",
                character: nil,
                job: "Producer",
                originalName: nil,
                popularity: 1.0
            )
        )
    }
}
