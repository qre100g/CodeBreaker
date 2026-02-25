//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by Mukesh Kondreddy on 16/02/26.
//

import SwiftUI

struct CodeBreakerView: View {
    // MARK: Data Own
    @State var game = CodeBreaker(pegCount: 5)
    
    // MARK: - Body
    var body: some View {
        VStack {
            CodeView(game: $game, code: game.master)
            ScrollView {
                CodeView(game: $game, code: game.guess)
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    CodeView(game: $game, code: game.attempts[index])
                }
            }
            
            Button("Restart game") {
                let emojies = ["🥰", "🥳", "😂", "😎", "😍"]
                let pegCount = Int.random(in: 3...6)
                let shouldPlayWithEmojies = Bool.random()
                let model = shouldPlayWithEmojies ? CodeBreaker(pegChoices: emojies, pegCount: pegCount) : CodeBreaker(pegCount: pegCount)
                game = model
            }
        }
        .padding()
    }
}

#Preview {
    CodeBreakerView()
}
