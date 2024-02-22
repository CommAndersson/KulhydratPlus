//
//  Master funktionsfil.swift
//  Kulhydrat+
//
//  Created by Sigurd Andersson on 07/02/2024.
//

import SwiftUI

import PhotosUI

struct Flashcard: Identifiable, Codable {
    var id = UUID()
    var navn: String
    var kulhydrat: Double
    var måleenhed: String
    var mængde: Double
    var aktivMængde: Double
}

class Deck: Identifiable, ObservableObject, Equatable, Hashable, Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case cards
    }
        static func == (lhs: Deck, rhs: Deck) -> Bool {
            return lhs.id == rhs.id
        }
        required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(UUID.self, forKey: .id)
            name = try container.decode(String.self, forKey: .name)
            cards = try container.decode([Flashcard].self, forKey: .cards)
        }
    
    init() {
            self.name = "Default Deck Name" // Provide a default name
            self.cards = [] // Initialize cards as empty
        }
    
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey: .id)
            try container.encode(name, forKey: .name)
            try container.encode(cards, forKey: .cards)
        }
    
        
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        var id = UUID()
        @Published var name: String
    @Published var cards: [Flashcard] = []
        
        init(name: String) {
            self.name = name
        }
    
    func removeCard(at index: Int) {
          cards.remove(at: index)
      }
    
  }
    
// Det kan godt være at hele denne class skal slettes men jeg tror den er nødvendig for at jeg kan lave et NavigaitonLink til hvert enkelt brugerdefineret billedkort
class Kort: Identifiable, ObservableObject, Equatable, Hashable {
    enum KortNøgle: String, CodingKey {
        case kortId
        case kortNavn
        
    }
    static func == (lhs: Kort, rhs: Kort) -> Bool {
        return lhs.kortId == rhs.kortId
    }
    required init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: KortNøgle.self)
        kortId = try container.decode(UUID.self, forKey: .kortId)
        kortNavn = try container.decode(String.self, forKey: .kortNavn)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: KortNøgle.self)
        try container.encode(kortId, forKey: .kortId)
        try container.encode(kortNavn, forKey: .kortNavn)
        
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(kortId)
    }
    
    var kortId = UUID()
    @Published var kortNavn: String
    @Published var cards: [Flashcard] = []
    
    init(kortNavn: String){
        self.kortNavn = kortNavn
    }
        
    }

    

class FlashcardManager: ObservableObject {
    @Published var decks: [Deck] = [] {
        didSet {
            saveDecks()
        }
    }

    // UserDefaults keys
    private let decksKey = "SavedDecks"

    init() {
        // Load saved decks on initialization
        loadDecks()
    }

    func addCard(to deck: Deck, navn: String, kulhydrat: Double, måleenhed: String, mængde: Double, aktivMængde: Double) {
        let newCard = Flashcard(navn: navn, kulhydrat: kulhydrat, måleenhed: måleenhed, mængde: mængde, aktivMængde: aktivMængde)
        if let index = decks.firstIndex(where: { $0.id == deck.id }) {
            self.decks[index].cards.append(newCard)
            saveDecks() // Save decks after adding a card
            print("Card added to deck '\(deck.name)': \(newCard)")
        } else {
            print("Error: Deck not found")
        }
    }
    
    func updateCard(in deck: Deck, cardID: UUID, newNavn: String?, newKulhydrat: Double?, newMåleenhed: String?, newMængde: Double?, newAktivMængde: Double?) {
        if let deckIndex = decks.firstIndex(where: { $0.id == deck.id }),
           let cardIndex = decks[deckIndex].cards.firstIndex(where: { $0.id == cardID }) {
            
            // Directly update the properties of the card in the array
            if let navn = newNavn {
                decks[deckIndex].cards[cardIndex].navn = navn
            }
            if let kulhydrat = newKulhydrat {
                decks[deckIndex].cards[cardIndex].kulhydrat = kulhydrat
            }
            if let måleenhed = newMåleenhed {
                decks[deckIndex].cards[cardIndex].måleenhed = måleenhed
            }
            if let mængde = newMængde {
                decks[deckIndex].cards[cardIndex].mængde = mængde
            }
            if let aktivMængde = newAktivMængde {
                decks[deckIndex].cards[cardIndex].aktivMængde = aktivMængde
            }

            saveDecks() // Save decks after updating a card
            print("Card updated in deck '\(deck.name)': \(decks[deckIndex].cards[cardIndex])")
        } else {
            print("Error: Deck or Card not found")
        }
    }



    func addDeck(name: String) {
        let newDeck = Deck(name: name)
        decks.append(newDeck)
        saveDecks() // Save after adding a deck
    }

    func saveDecks() {
        do {
            let encoder = JSONEncoder()
            let encodedDecks = try encoder.encode(decks)
            UserDefaults.standard.set(encodedDecks, forKey: decksKey)
        } catch {
            print("Error encoding decks: \(error)")
        }
    }
    

    private func loadDecks() {
        if let savedDecks = UserDefaults.standard.data(forKey: decksKey) {
            do {
                let decoder = JSONDecoder()
                decks = try decoder.decode([Deck].self, from: savedDecks)
            } catch {
                print("Error decoding decks: \(error)")
            }
        }
    }

}

class FlashcardCreationManager: ObservableObject {
    @Published var newNavn = ""
    @Published var newKulhydrat = ""
    @Published var newMåleenhed = ""
    @Published var newMængde = ""
    
    func clear() {
        newNavn = ""
        newKulhydrat = ""
        newMåleenhed = ""
        newMængde = ""
    }
}
