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
    
    var body: some View {
        VStack {
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Button("Shuffle") {
                viewModel.shuffle()
            }
            // cardCountAdjustersView
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(.orange)
    }
    
    //    var cardCountAdjustersView: some View {
    //        HStack {
    //            cardRemover
    //            Spacer()
    //            cardAdder
    //        }
    //        .imageScale(.large)
    //        .font(.largeTitle)
    //    }
    //
    //    var cardRemover: some View {
    //        cardCountAdjuster(offset: -1, symbol: "rectangle.stack.badge.minus.fill")
    //    }
    //
    //    var cardAdder: some View {
    //        cardCountAdjuster(offset: +1, symbol: "rectangle.stack.badge.plus.fill")
    //    }
    //
    //    func cardCountAdjuster(offset: Int, symbol: String) -> some View{
    //        Button(action: {
    //            .cardCount += offset
    //        }, label: {
    //            Image(systemName: symbol)
    //        })
    //        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    //    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
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
            base
                .fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
    }
}


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}

#Preview {
    CardView(EmojiMemoryGame().cards.first!)
}
