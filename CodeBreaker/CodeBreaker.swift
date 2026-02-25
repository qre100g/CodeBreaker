//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by Mukesh Kondreddy on 17/02/26.
//

import Foundation

typealias Peg = String

struct CodeBreaker {
    var master: Code
    var guess: Code
    var attempts: [Code] = []
    let pegChoices: [Peg]
    
    init(pegChoices: [Peg] = ["red", "green", "blue", "yellow"], pegCount: Int = 4) {
        self.pegChoices = pegChoices
        self.master = Code(kind: .master, pegCount: pegCount)
        self.guess  = Code(kind: .guess, pegCount: pegCount)
        master.randomize(from: pegChoices)
        print("masterCode = \(master.pegs)")
    }
    
    mutating func changeGuessPeg(_ peg: Peg, at index: Int) {
        if index >= 0 && index < guess.pegs.count {
            guess.pegs[index] = peg
        }
    }
    
    mutating func attemptGuess() {
        guard
            guess.pegs.contains(Code.missing) == false,
            attempts.contains(where: { $0.pegs == guess.pegs }) == false
        else {
            return
        }

        var attempt = guess
        attempt.kind = .attempt(attempt.match(against: master))
        attempts.append(attempt)
        
        guess.reset()
    }
}


