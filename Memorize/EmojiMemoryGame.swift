//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Keiichi Taira on 11/24/23.
//

import SwiftUI

class EmojiMemoryGame {
    private static let emojis = ["👻", "💀", "🎃", "🕷️", "🕸️", "🧙🏻", "😈", "🧟‍♀️", "☠️", "😱", "🦇", "🧛🏼"]
    
    private var model = MemoryGame(numberOfPairsOfCards: 4) { pairIndex in
        return EmojiMemoryGame.emojis[pairIndex] // can be written as emojis[pairIndex]
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card: card)
    }
}
