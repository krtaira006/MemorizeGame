//
//  ContentView.swift
//  Memorize
//
//  Created by Keiichi Taira on 11/20/23.
//

import SwiftUI

struct ContentView: View {
    
    let emojis = ["👻", "💀", "🎃", "🕷️"]
    
    @State var cardCount: Int = 4
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            cardCountAdjustersView
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]) {
            ForEach(0..<cardCount, id: \.self) { i in
                CardView(content: emojis[i])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardCountAdjustersView: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(offset: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(offset: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    func cardCountAdjuster(offset: Int, symbol: String) -> some View{
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
}

#Preview {
    ContentView()
}
