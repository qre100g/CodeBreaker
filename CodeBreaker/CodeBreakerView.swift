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
    
    @State var selection: Int = 0
    
    // MARK: - Body
    var body: some View {
        VStack {
            CodeView(code: game.master)
            ScrollView {
                CodeView(code: game.guess, selection: $selection) { guessButton }

                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    CodeView(
                        code: game.attempts[index]) {
                            MatchMarkers(matches: game.attempts[index].match(against: game.master))
                        }
                }
            }
            
            HStack {
                ForEach(game.pegChoices.indices, id: \.self) { index in
                    PegView(peg: game.pegChoices[index])
                        .onTapGesture {
                            game.changeGuessPeg(game.pegChoices[index], at: selection)
                            selection = (selection + 1) % game.master.pegs.count
                        }
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
