//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Keiichi Taira on 11/20/23.
//  This file is the main view of the app 

import SwiftUI
//View
struct EmojiMemoryGameView: View {
    
    typealias Card = MemoryGame<String>.Card
    @ObservedObject var viewModel: EmojiMemoryGame
    @State private var showAlert = false
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 4
    
    // shuffle before the cards are dealt
    
    
    var body: some View {
        VStack {
            score
                .font(.largeTitle)
            cards
                .foregroundStyle(LinearGradient(
                    gradient: Gradient(colors: [viewModel.p2, viewModel.p1]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing))
                .padding(22)
            HStack {
                restart
                Spacer()
                deck
                    .foregroundStyle(LinearGradient(
                        gradient: Gradient(colors: [viewModel.p2, viewModel.p1]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing))
                Spacer()
                shuffle
            }
            .font(.largeTitle)
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Game Over"),
                  message: Text("Congratulations! Your score is \(viewModel.score)!"),
                  dismissButton: .default(Text("Restart")) {
                viewModel.restart()
                  }
            )
        }
        .onReceive(viewModel.$allCardsMatched) { allMatched in
            if allMatched {
                showAlert = true
            }
            
        }
    }
    private var score: some View {
        Text("Score: \(viewModel.score)")
            .animation(nil)
    }
    private var shuffle: some View {
        Button("Shuffle") {
            withAnimation{
                viewModel.shuffle()
            }
        }
    }
    
    private var restart: some View {
        Button("Restart") {
            withAnimation {
                viewModel.restart()
            }
        }
    }
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            if isDealt(card) {
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(spacing)
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 1 : 0)
                    .onTapGesture {
                        choose(card)
                    }
            }
        }
    }
    
    // represent the set of cards that have been dealt if dealt has no Card then no cards have been dealt
    @State private var dealt = Set<Card.ID>()
    
    //check if dealt has the specific card. if it contains, then it has been dealt
    private func isDealt(_ card: Card) -> Bool {
        dealt.contains(card.id)
    }
    
    private var undealtCards: [Card] {
        viewModel.cards.filter { !isDealt($0) }
    }
    
    @Namespace private var dealingNamespace
    
    private var deck: some View {
        ZStack {
            ForEach(undealtCards) { card in
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AsymmetricTransition(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
        .onTapGesture {
            deal()
        }
    }
    
    private func deal() {
        //lets shuffle the cards before we deal
        viewModel.shuffle()
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(.easeInOut(duration: 1).delay(delay)) {
                _ = dealt.insert(card.id)
            }
            delay += 0.1
        }
    }
    
    private let deckWidth: CGFloat = 50
    
    private func choose(_ card: Card) {
        withAnimation{
            let scoreBeforeChoosing = viewModel.score
            viewModel.choose(card)
            let scoreChange = viewModel.score - scoreBeforeChoosing
            lastScoreChange = (scoreChange, causedByCardId: card.id)
        }
    }
    @State private var lastScoreChange = (0, causedByCardId: UUID())
    
    private func scoreChange(causedBy card: Card) -> Int {
        let (amount, Id) = lastScoreChange
        return card.id == Id ? amount : 0
    }
    
    
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
