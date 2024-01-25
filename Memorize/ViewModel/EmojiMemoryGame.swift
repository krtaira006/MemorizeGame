//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Keiichi Taira on 11/24/23.
//  This file is the ViewModel of the app

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    private static let emojis = ["😎", "😍", "😜", "🤩", "🐶", "🦊", "🐸", "🐽", "🐵", "🐨", "🐯", "🦁", "🐮", "🐷", "🐼", "🐵"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards:8) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return EmojiMemoryGame.emojis[pairIndex]
            }
            else {
                return "⁉️"
            }
             // can be written as emojis[pairIndex]
        }
    }
    
    //This
    @Published private var model = createMemoryGame()
    @Published var allCardsMatched: Bool = false
    
    var cards: Array<Card> {
        return model.cards
    }
    
    var p1: Color {
        return .p1
    }
    
    var p2: Color {
        return .p2
    }
    
    var score: Int {
        return model.score
    }
    
    // Mark: - Intents
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: Card) {
        model.choose(card: card)
        handleCardSateChanged()
    }
    
    func restart() {
        model = EmojiMemoryGame.createMemoryGame()
    }
    
    func updateAllCardMatched() {
        allCardsMatched = model.cards.allSatisfy { $0.isMatched }
    }
    
    func handleCardSateChanged() {
        updateAllCardMatched()
    }
}
