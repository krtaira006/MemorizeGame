//
//  CardView.swift
//  Memorize
//
//  Created by Keiichi Taira on 11/20/23.
//

import SwiftUI

struct CardView: View {
    
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base : RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            Group {
                base
                    .fill(.white)
                    .strokeBorder(lineWidth: 4)
                Text(content)
                    .font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base
                .fill()
                .opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    CardView(content: "😂")
}
