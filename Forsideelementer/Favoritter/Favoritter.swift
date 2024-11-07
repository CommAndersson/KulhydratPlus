//
//  Favoritter.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 25/06/2024.
//


import SwiftUI

struct Favoritter: View {
    @EnvironmentObject var favoritesManager: FavoritesManager
    @EnvironmentObject var flashcardManager: FlashcardManager
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    
    var filteredAndSortedFavorites: [(key: String, value: [FavoriteItem])] {
        let validFavorites = favoritesManager.favoriteItems.filter { item in
            switch item {
            case .categoryItem(_):
                return true
            case .brugerdefineredeKort(let card):
                return card.managedObjectContext != nil && !card.isDeleted
            }
        }
        
        let filteredItems = validFavorites.filter {
            searchText.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(searchText)
        }
        
        let sortedItems = filteredItems.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        let grouped = Dictionary(grouping: sortedItems) { String($0.name.prefix(1).uppercased()) }
        return grouped.sorted { $0.key < $1.key }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("GrønBaggrund")
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    SearchBar(text: $searchText)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    List {
                        ForEach(filteredAndSortedFavorites, id: \.key) { section in
                            Section(header: Text(section.key)) {
                                ForEach(section.value, id: \.id) { item in
                                    ZStack {
                                        NavigationLink(
                                            destination: {
                                                switch item {
                                                case .categoryItem(let categoryItem):
                                                    categoryItem.destinationView()
                                                        .environmentObject(favoritesManager)
                                                case .brugerdefineredeKort(let card):
                                                    if let category = card.kategorierRelation {
                                                        FlashcardDetailView(
                                                            flashcard: card,
                                                            flashcardManager: flashcardManager,
                                                            selectedDeck: .constant(category),
                                                            deck: category
                                                        )
                                                        .environmentObject(favoritesManager)
                                                    } else {
                                                        Text("Kort detaljer er ikke tilgængelige")
                                                            .foregroundColor(.gray)
                                                    }
                                                }
                                            }
                                        ) {
                                            EmptyView()
                                        }
                                        .opacity(0)
                                        
                                        HStack {
                                            Group {
                                                switch item {
                                                case .categoryItem(let categoryItem):
                                                    Image(categoryItem.Billede)
                                                        .resizable()
                                                        .scaledToFill()
                                                case .brugerdefineredeKort(let card):
                                                    if let imageData = card.imageData,
                                                       let uiImage = UIImage(data: imageData) {
                                                        Image(uiImage: uiImage)
                                                            .resizable()
                                                            .scaledToFill()
                                                    } else {
                                                        Image("Placeholder")
                                                            .resizable()
                                                            .scaledToFill()
                                                    }
                                                }
                                            }
                                            .frame(width: 55, height: 55)
                                            .cornerRadius(5)
                                            .clipped()
                                            .padding(.leading, 12)
                                            
                                            Text(item.name)
                                                .foregroundColor(.primary)
                                                .font(.headline)
                                            Spacer()
                                        }
                                        .padding(.vertical, 0)
                                    }
                                    .listRowBackground(
                                        Color("GrønEmneBaggrund")
                                            .cornerRadius(10)
                                            .padding(2)
                                            .frame(width: 380, height: 70)
                                    )
                                    .contentShape(Rectangle())
                                    .listRowSeparator(.hidden)
                                }
                            }
                            .headerProminence(.increased)
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Favoritter")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.backward")
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


