//
//  PegChooser.swift
//  CodeBreaker
//
//  Created by Mukesh Kondreddy on 28/03/26.
//

import SwiftUI

struct PegChooser: View {
    let pegChoices: [Peg]
    let onChoosePeg: (Peg) -> Void

    var body: some View {
        HStack {
            ForEach(pegChoices.indices, id: \.self) { index in
                PegView(peg: pegChoices[index])
                    .onTapGesture {
                        onChoosePeg(pegChoices[index])
                    }
            }
        }
    }
}
