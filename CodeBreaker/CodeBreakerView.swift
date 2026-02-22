//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by Mukesh Kondreddy on 16/02/26.
//

import SwiftUI

struct CodeBreakerView: View {
    @State var game = CodeBreaker(pegCount: 5)
    
    var body: some View {
        VStack {
            view(for: game.master)
            ScrollView {
                view(for: game.guess)
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    view(for: game.attempts[index])
                }
            }
            
            Button("Restart game") {
                game = CodeBreaker(pegCount: Int.random(in: 3...6))
            }
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
    
    func view(for code: Code) -> some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .overlay {
                        if code.pegs[index] == Code.missing {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.gray)
                        }
                    }
                    .contentShape(Rectangle())
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(code.pegs[index].toColor)
                    .onTapGesture {
                        if code.kind == .guess {
                            game.changeGuessPeg(at: index)
                        }
                    }
                    .opacity(code.kind == .master ? 0 : 1)
            }
            
            MatchMarkers(matches: code.matches)
                .overlay {
                    if code.kind == .guess {
                        guessButton
                    }
                }
        }
    }
}

extension String {
    var toColor: Color {
        switch self {
        case "red": .red
        case "green": .green
        case "blue": .blue
        case "yellow": .yellow
        case "clear": .clear

        default: .clear
        }
    }
}

#Preview {
    CodeBreakerView()
}
