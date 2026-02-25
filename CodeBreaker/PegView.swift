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
        RoundedRectangle(cornerRadius: 10)
            .overlay {
                if peg == Code.missing {
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color.gray)
                }
            }
            .contentShape(Rectangle())
            .aspectRatio(1, contentMode: .fit)
            .foregroundStyle(peg.toColor ?? Color.clear)
            .overlay { showTextView(for: peg) }
    }
    
    @ViewBuilder
    func showTextView(for peg: Peg) -> some View {
        if peg.toColor == nil {
            Text(peg)
                .font(.system(size: 120))
                .minimumScaleFactor(9/120)
        }
    }
}
