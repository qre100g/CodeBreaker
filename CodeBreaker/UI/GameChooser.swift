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
            GameChooserList(games: $games, selection: $selection)
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
    }
}


#Preview {
    GameChooser()
}
