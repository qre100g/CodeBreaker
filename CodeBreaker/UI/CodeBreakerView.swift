//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by Mukesh Kondreddy on 16/02/26.
//

import SwiftUI

struct CodeBreakerView: View {
    // MARK: Data passed
    @Binding var game: CodeBreaker

    // MARK: Data Own
    @State var selection: Int = 0
    
    init(game: Binding<CodeBreaker>) {
        self._game = game
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            CodeView(code: game.master) { ElapsedTime(startTime: game.startTime, endTime: game.endTime) }
            ScrollView {
                
                if !game.isOver {
                    CodeView(code: game.guess, selection: $selection) { guessButton }
                }

                guessAttemptsView
            }
            
            if !game.isOver {
                pegChooserView
            }
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button("Restart game", systemImage: "arrow.clockwise") {
                    restartGame()
                }
            }
        }
        .padding()
    }
    
    var guessButton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
                selection = 0
            }
        }
        .font(.system(size: 80))
        .minimumScaleFactor(0.1)
    }
    
    var pegChooserView: some View {
        PegChooser(pegChoices: game.pegChoices) { peg in
            game.changeGuessPeg(peg, at: selection)
            selection = (selection + 1) % game.master.pegs.count
        }
    }
    
    var guessAttemptsView: some View {
        ForEach(game.attempts.indices.reversed(), id: \.self) { index in
            CodeView(
                code: game.attempts[index]) {
                    MatchMarkers(matches: game.attempts[index].match(against: game.master))
                }
        }
    }
    
    func restartGame() {
        let emojies = ["🥰", "🥳", "😂", "😎", "😍"]
        let pegCount = Int.random(in: 3...6)
        let shouldPlayWithEmojies = Bool.random()
        let model = shouldPlayWithEmojies ? CodeBreaker(pegChoices: emojies, pegCount: pegCount) : CodeBreaker(pegCount: pegCount)
        game = model
    }
}

