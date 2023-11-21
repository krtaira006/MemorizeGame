//
//  ContentView.swift
//  Memorize
//
//  Created by Keiichi Taira on 11/20/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView()
            CardView(isFaceUp: false)
            CardView(isFaceUp: false)
        }
        .foregroundStyle(.orange)
        .padding()
    }
}

#Preview {
    ContentView()
}
