//
//  PegView.swift
//  CodeBreaker
//
//  Created by Mukesh Kondreddy on 26/02/26.
//

import SwiftUI

struct PegView: View {
    let peg: Peg

    var body: some View {
        Circle()
            .contentShape(Rectangle())
            .padding(5)
            .aspectRatio(1, contentMode: .fit)
            .foregroundStyle(peg)
    }
}
