//
//  Code.swift
//  CodeBreaker
//
//  Created by Mukesh Kondreddy on 25/02/26.
//


import Foundation

struct Code {
    var kind: Kind
    var pegs: [Peg]
    
    init(kind: Kind, pegCount: Int) {
        self.kind = kind
        self.pegs = Array(repeating: "clear", count: pegCount)
    }
    
    static let missing = "clear"
    
    enum Kind: Equatable {
        case master
        case guess
        case attempt([Match])
    }
    
    var matches: [Match] {
        switch kind {
        case .attempt(let matches): return matches
        default: return []
        }
    }
    
    mutating func randomize(from pegChoices: [Peg]) {
        for index in pegs.indices {
            pegs[index] = pegChoices.randomElement() ?? Code.missing
        }
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
