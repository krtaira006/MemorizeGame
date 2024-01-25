//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Keiichi Taira on 11/20/23.
//

import SwiftUI
//View
struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        VStack {
            cards
                .animation(.default, value: viewModel.cards)
            Button("Shuffle") {
                viewModel.shuffle()
            }
            //cardCountAdjustersView
        }
        .padding()
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
        .foregroundColor(.orange)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            //The card when its faced up
            Group {
                base
                    .fill(.white)
                    .strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 250))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            //The card when its faced down
            base
                .fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}

//#Preview {
//    CardView(EmojiMemoryGame().cards.first!)
//}
