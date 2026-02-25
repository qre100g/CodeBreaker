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
            CodeView(code: game.master)
            ScrollView {
                CodeView(code: game.guess) { index in
                    game.changeGuessPeg(at: index)
                } accessoryView: { guessButton }
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    CodeView(
                        code: game.attempts[index],
                        accessoryView: {
                            MatchMarkers(matches: game.attempts[index].match(against: game.master))
                        })
                }
            }
            
            Button("Restart game") { restartGame() }
        }
        .padding()
    }
    
    var guessButton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
            }
        }
        .font(.system(size: 80))
        .minimumScaleFactor(0.1)
    }
    
    func restartGame() {
        let emojies = ["🥰", "🥳", "😂", "😎", "😍"]
        let pegCount = Int.random(in: 3...6)
        let shouldPlayWithEmojies = Bool.random()
        let model = shouldPlayWithEmojies ? CodeBreaker(pegChoices: emojies, pegCount: pegCount) : CodeBreaker(pegCount: pegCount)
        game = model
    }
}

#Preview {
    CodeBreakerView()
}
