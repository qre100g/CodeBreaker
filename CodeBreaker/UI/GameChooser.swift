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
                ForEach($games, id: \.self) { $game in
                    NavigationLink {
                        CodeBreakerView(game: $game)
                            .navigationTitle(game.name)
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        GameSummary(game: game)
                    }
                }
                .onDelete { offsets in
                    games.remove(atOffsets: offsets)
                }
                .onMove { offsets, offset in
                    games.move(fromOffsets: offsets, toOffset: offset)
                }
            }
            .listStyle(.plain)
            .navigationTitle("Summary")
            .toolbar {
                EditButton()
            }
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
