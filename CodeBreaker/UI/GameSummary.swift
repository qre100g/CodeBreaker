//
//  GameSummary.swift
//  CodeBreaker
//
//  Created by Mukesh Kondreddy on 28/03/26.
//

import SwiftUI

struct GameSummary: View {
    // MARK: Data passed to this view
    let game: CodeBreaker

    var body: some View {
        VStack(alignment: .leading) {
            Text(game.name)
                .font(Font.headline)
            
            PegChooser(pegChoices: game.pegChoices)
            
            Text("Attempts: \(game.attempts.count)")
        }
    }
}
