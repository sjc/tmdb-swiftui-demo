//
//  HeroImageView.swift
//  MovieInfo
//
//  Created by Stuart Crook on 25/04/2023.
//

import SwiftUI

struct HeroImageView: View {

    let title: String
    let imagePath: String?
    
    var body: some View {
        AsyncImage(url: imagePath?.largeImageURL) { phase in
            switch phase {
            case .empty:
                if imagePath?.largeImageURL == nil {
                    EmptyView()
                } else {
                    ProgressView()
                        .tint(Color.white)
                }
            case .success(let image):
                image.resizable()
                    .aspectRatio(contentMode: .fit)
            case .failure:
                EmptyView()
            @unknown default:
                EmptyView()
            }
        }
        .aspectRatio(contentMode: .fit)
        .background(Color.gray)
        .overlay(alignment: .bottomLeading) {
            Text(title)
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.all)
        }
    }
}

struct HeroImageView_Previews: PreviewProvider {
    static var previews: some View {
        HeroImageView(
            title: "This is a Hero Image",
            imagePath: "/dtGxDOcFssdUUTYBr6M6INXTI1e.jpg"
        )
    }
}
