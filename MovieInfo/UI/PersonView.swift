//
//  PersonView.swift
//  MovieInfo
//
//  Created by Stuart Crook on 24/04/2023.
//

import SwiftUI

struct PersonView: View {
    
    let result: SearchResult
    let repository: Repository
    
    @State private var person: Person?
    @State private var errorMessage: String?

    var body: some View {
        if let person = person {
            view(forPerson: person)
        } else if let errorMessage = errorMessage {
            Text(errorMessage)
        } else {
            view(forSearchResult: result)
                .task {
                    await fetchPerson()
                }
        }
    }
    
    func view(forSearchResult: SearchResult) -> some View {
        VStack {
            headerView(
                imagePath: result.posterPath,
                name: result.title
            )
            Spacer()
            ProgressView()
                .padding(.all)
            Spacer()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func view(forPerson person: Person) -> some View {
        List {
            headerView(
                imagePath: person.posterPath,
                name: person.name,
                dates: person.dates,
                place: person.placeOfBirth
            )
            .listRowSeparator(.hidden)
            Text(person.biography)
                .padding(.all)
                .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func headerView(imagePath: String?, name: String, dates: String = "", place: String = "") -> some View {
        HStack {
            AsyncImage(url: imagePath?.smallImageURL) { phase in
                switch phase {
                case .empty:
                    if result.posterPath?.smallImageURL == nil {
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
                Text(place)
            }
        }
    }
    
    func fetchPerson() async {
        let result = await repository.fetch(personId: result.id)
        switch result {
        case .failure(let error):
            self.errorMessage = error.localizedDescription
        case .success(let person):
            self.person = person
        }
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        let repository = MockRepository()
        PersonView(
            result: repository.searchResultsToReturn![2],
            repository: repository
        )
    }
}
