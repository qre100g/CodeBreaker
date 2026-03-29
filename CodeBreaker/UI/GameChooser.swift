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
    @State private var selection: CodeBreaker? = nil

    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                ForEach(games, id: \.self) { game in
                    NavigationLink(value: game) {
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
        } detail: {
            if let selection = selection {
                CodeBreakerView(game: selection)
                    .navigationTitle(selection.name)
                    .navigationBarTitleDisplayMode(.inline)
            } else {
                Text("Choose Game")
            }
        }
        .onAppear {
            games.append(CodeBreaker(name: "First Game"))
            games.append(CodeBreaker(name: "Second Game"))
            games.append(CodeBreaker(name: "Third Game"))
            selection = games.first
        }
    }
}


#Preview {
    GameChooser()
}
