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
            //creates a pair of cards by adding into the array twice
            cards.append(Card(isFaceUp: false, isMatched: false, content: content))
            cards.append(Card(isFaceUp: false, isMatched: false, content: content))
        }
    }
    
    // receives an index of the first card chosen
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { index in cards[index].isFaceUp }.only
        }
        set {
            return cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) }
        }
    }
    
    mutating func choose(card: Card) {
        //This line checks if the chosen card exists
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            //This checks if the chosen card is faced down and the card that is not matched yet
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                //This line checks if the chosen card is the 1st or 2nd card. if 2nd, it check if 1st == 2nd card
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var id = UUID()
        var isFaceUp: Bool
        var isMatched: Bool
        let content: CardContent
        
        var debugDescription: String {
            return "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "no")"
        }
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
