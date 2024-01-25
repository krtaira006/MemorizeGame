//
//  SwiftUIView.swift
//  Memorize
//
//  Created by Keiichi Taira on 1/25/24.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemoryGame<String>.Card
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                .opacity(Constants.Pie.opacity)
                .overlay(cardContents.padding(Constants.Pie.inset))
                .padding(Constants.inset)
                .cardify(isFaceUp: card.isFaceUp)
                .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
        }
    }
    var cardContents: some View {
        Text(card.content)
            .font(.system(size: Constants.FontSize.largest))
            .minimumScaleFactor(Constants.FontSize.scaleFactor)
            .multilineTextAlignment(.center)
            .aspectRatio(1, contentMode: .fit)
            .rotationEffect(.degrees(card.isMatched ? 360 : 0))
            .animation(.spin(duration: 1), value: card.isMatched)
    }
    
    private struct Constants {
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 0.4
            static let inset: CGFloat = 5
        }
    }
}

extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: 1).repeatForever(autoreverses: false)
    }
}

//preview will be written later
struct CardView_Previews: PreviewProvider {
    typealias Card = CardView.Card
    
    static var previews: some View {
        VStack {
            HStack {
                CardView(Card(isFaceUp: true, content: "X"))
                    .aspectRatio(4/3, contentMode: .fit)
                CardView(Card(content: "X"))
            }
            HStack {
                CardView(Card(isFaceUp: true, isMatched: true, content: "This is a very long string and I hope it fits"))
                CardView(Card(isMatched: true, content: "X"))
            }
        }
        .padding()
        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.blue, .white, .green]), startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}
