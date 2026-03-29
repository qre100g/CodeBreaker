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
<<<<<<< HEAD
            games.append(CodeBreaker(name: "First Game"))
            games.append(CodeBreaker(name: "Second Game"))
            games.append(CodeBreaker(name: "Third Game"))
=======
<<<<<<< HEAD:CodeBreaker/UI/GameChooser.swift
            games.append(CodeBreaker(name: "First Game"))
            games.append(CodeBreaker(name: "Second Game"))
            games.append(CodeBreaker(name: "Third Game"))
=======
            if games.isEmpty {
                games = [
                    CodeBreaker(name: "First Game"),
                    CodeBreaker(name: "Second Game"),
                    CodeBreaker(name: "Third Game")
                ]
            }
>>>>>>> 92cf32a (Add a third game):CodeBreaker/UI/CodeBreakerSummary.swift
>>>>>>> cfca396 (Append the models to the game instead of assigning to the array.)
        }
    }
}


#Preview {
    GameChooser()
}
