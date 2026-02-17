//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by Mukesh Kondreddy on 17/02/26.
//

import Foundation
import SwiftUI

typealias Peg = Color

struct CodeBreaker {
    let master: Code = Code(kind: .master)
    var guess: Code = Code(kind: .guess)
    var attempts: [Code] = []
    let pegChoices: [Peg] = [.red, .green, .blue, .yellow]
    
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
        var attempt = guess
        attempt.kind = .attempt
        attempts.append(attempt)
    }
}

struct Code {
    var kind: Kind
    var pegs: [Peg] = [.green, .green, .red, .yellow]
    
    static let missing = Color.clear
    
    enum Kind {
        case master
        case guess
        case attempt
    }
    
    func match(against otherCode: Code) -> [Match] {
        var result = Array(repeating: Match.nomatch, count: pegs.count)
        var pegsToMatch = otherCode.pegs
        
        for index in pegs.indices.reversed() {
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
                result[index] = .exact
                pegsToMatch.remove(at: index)
            }
        }
        
        for index in pegs.indices {
            if result[index] != .exact {
                if let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
                    result[index] = .inexact
                    pegsToMatch.remove(at: matchIndex)
                }
            }
        }
        
        return result
    }
}
