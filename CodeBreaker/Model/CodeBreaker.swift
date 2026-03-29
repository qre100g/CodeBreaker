//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by Mukesh Kondreddy on 17/02/26.
//

import Foundation

typealias Peg = String

@Observable
class CodeBreaker {
    var master: Code
    var guess: Code
    var attempts: [Code] = []
    private(set) var pegChoices: [Peg]
    let name: String
    
    var startTime: Date = .now
    var endTime: Date? = nil
    
    var isOver: Bool = false
    
    init(
        name: String = "Code Breaker",
        pegChoices: [Peg] = ["red", "green", "blue", "yellow"],
        pegCount: Int = 4
    ) {
        self.name = name
        self.pegChoices = pegChoices
        self.master = Code(kind: .master(isHidden: true), pegCount: pegCount)
        self.guess  = Code(kind: .guess, pegCount: pegCount)
        master.randomize(from: pegChoices)
        print("masterCode = \(master.pegs)")
    }
    
    func changeGuessPeg(_ peg: Peg, at index: Int) {
        if index >= 0 && index < guess.pegs.count {
            guess.pegs[index] = peg
        }
    }
    
    func attemptGuess() {
        guard
            guess.pegs.contains(Code.missing) == false,
            attempts.contains(where: { $0.pegs == guess.pegs }) == false
        else {
            return
        }

        var attempt = guess
        attempt.kind = .attempt(attempt.match(against: master))
        attempts.append(attempt)
        
        if guess.pegs == master.pegs {
            endTime = .now
            isOver = true
            master.kind = .master(isHidden: false)
        }
        
        guess.reset()
    }
    
    func populateValues(
        pegChoices: [Peg] = ["red", "green", "blue", "yellow"],
        pegCount: Int
    ) {
        self.pegChoices = pegChoices
        self.master = Code(kind: .master(isHidden: true), pegCount: pegCount)
        self.guess  = Code(kind: .guess, pegCount: pegCount)
        master.randomize(from: pegChoices)
    }
    
    func restartGame() {
        let emojies = ["🥰", "🥳", "😂", "😎", "😍"]
        let pegCount = Int.random(in: 3...6)
        let shouldPlayWithEmojies = Bool.random()
        startTime = .now
        endTime = nil
        
        if shouldPlayWithEmojies {
            self.populateValues(pegChoices: emojies, pegCount: pegCount)
        } else {
            self.populateValues(pegCount: pegCount)
        }
    }
}

extension CodeBreaker: Identifiable, Hashable {
    static func == (lhs: CodeBreaker, rhs: CodeBreaker) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
