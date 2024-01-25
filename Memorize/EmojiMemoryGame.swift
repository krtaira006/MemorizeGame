//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Keiichi Taira on 11/24/23.
// ViewModel

import SwiftUI

class EmojiMemoryGame: ObservableObject{
    private static let emojis = ["👻", "💀", "🎃", "🕷️", "🕸️", "🧙🏻", "😈", "🧟‍♀️", "☠️", "😱", "🦇", "🧛🏼"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 11) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return EmojiMemoryGame.emojis[pairIndex]
            }
            else {
                return "⁉️"
            }
             // can be written as emojis[pairIndex]
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // Mark: - Intents
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
