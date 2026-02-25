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
    
    mutating func changeGuessPeg(at index: Int) {
        let existingPeg = guess.pegs[index]
        if let indexOfExistingPegInPegChoices = pegChoices.firstIndex(of: existingPeg) {
            let newPeg = pegChoices[(indexOfExistingPegInPegChoices + 1) % pegChoices.count]
            guess.pegs[index] = newPeg
        } else {
            guess.pegs[index] = pegChoices.first ?? Code.missing
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
    }
}


