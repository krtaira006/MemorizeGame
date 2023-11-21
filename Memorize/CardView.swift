//
//  CardView.swift
//  Memorize
//
//  Created by Keiichi Taira on 11/20/23.
//

import SwiftUI

struct CardView: View {
    
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base : RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base
                    .fill(.white)
                    .strokeBorder(lineWidth: 4)
                Text("🐶")
                    .font(.largeTitle)
            }
            else {
                base
                    .fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
            print("tapped")
        }
    }
}

#Preview {
    CardView()
}
