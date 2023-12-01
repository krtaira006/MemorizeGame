//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Keiichi Taira on 11/24/23.
//

import Foundation
// MODEL
struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = [Card]()
        //add numberOfPairsOfCards x 2 cards
        for pairIndex in 0 ..< max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(isFaceUp: true, isMatched: false, content: content))
            cards.append(Card(isFaceUp: true, isMatched: false, content: content))
        }
    }
    
    mutating func choose(card: Card) {
        let chosenIndex = index(of: card)
        cards[chosenIndex].isFaceUp.toggle() //reference type and value type matters here
    }
    func index(of card: Card) -> Int {
        for index in cards.indices {
            if cards[index].id == card.id {
                return index
            }
        }
        return 0 // FIXME: bogus
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card: Equatable, Identifiable {
        var id = UUID()
        var isFaceUp: Bool
        var isMatched: Bool
        let content: CardContent
    }
}
