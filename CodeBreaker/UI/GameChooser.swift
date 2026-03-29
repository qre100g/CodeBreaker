//
//  CodeBreakerSummary.swift
//  CodeBreaker
//
//  Created by Mukesh Kondreddy on 28/03/26.
//

import SwiftUI

struct GameChooser: View {
    // MARK: Data owned by view
    @State var games: [CodeBreaker] = []

    var body: some View {
        NavigationStack {
            List {
                ForEach(games.indices, id: \.self) { index in
                    NavigationLink {
                        CodeBreakerView(game: $games[index])
                            .navigationTitle(games[index].name)
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        GameSummary(game: games[index])
                    }
                }
            }
            .navigationTitle("Summary")
        }
        .onAppear {
            if games.isEmpty {
                games = [
                    CodeBreaker(name: "First Game"),
                    CodeBreaker(name: "Second Game"),
                    CodeBreaker(name: "Third Game")
                ]
            }
        }
    }
}


#Preview {
    GameChooser()
}
