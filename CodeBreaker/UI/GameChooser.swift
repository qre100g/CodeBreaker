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
            .listStyle(.plain)
        }
        .onAppear {
            games.append(CodeBreaker(name: "First Game"))
            games.append(CodeBreaker(name: "Second Game"))
            games.append(CodeBreaker(name: "Third Game"))
        }
    }
}


#Preview {
    GameChooser()
}
