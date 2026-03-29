//
//  GameChooserList.swift
//  CodeBreaker
//
//  Created by Mukesh Kondreddy on 30/03/26.
//

import SwiftUI

struct GameChooserList: View {

    // MARK: Data shared with me
    @Binding var games: [CodeBreaker]
    @Binding var selection: CodeBreaker?

    var body: some View {
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
        .onAppear {
            addGames()
        }
    }
    
    func addGames() {
        if games.isEmpty {
            games.append(CodeBreaker(name: "Earth Tones", pegChoices: [.blue, .purple, .orange]))
            games.append(CodeBreaker(name: "Favorite Game", pegChoices: [.red, .brown, .pink, .blue, .secondary]))
            games.append(CodeBreaker(name: "Third Game"))
            selection = games.first
        }
    }
}

#Preview {
    @Previewable @State var games = [CodeBreaker(name: "Earth Tones", pegChoices: [.blue, .purple, .orange])]
    NavigationStack {
        GameChooserList(games: $games, selection: .constant(nil))
    }
}
