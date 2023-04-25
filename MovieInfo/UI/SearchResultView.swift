//
//  SearchResultView.swift
//  MovieInfo
//
//  Created by Stuart Crook on 24/04/2023.
//

import SwiftUI

struct SearchResultView: View {
    
    let result: SearchResult
    
    var body: some View {
        HStack {
            AsyncImage(url: result.posterPath?.smallImageURL) { phase in
                switch phase {
                case .empty:
                    // AsyncImage is okay with a nil URL, but it uses the same
                    //  `.empty` state for it as initial loading, so we need to
                    //  check whether it is trying to load or not
                    if result.posterPath?.smallImageURL == nil {
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
            VStack(alignment: .leading) {
                Text(result.title)
                    .font(.title)
                Text(result.subtitle)
                    .font(.subheadline)
            }
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(result: MockRepository().searchResultsToReturn![0])
    }
}
