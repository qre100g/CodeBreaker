//
//  CodeView.swift
//  CodeBreaker
//
//  Created by Mukesh Kondreddy on 25/02/26.
//

import SwiftUI

struct CodeView<AccessoryView>: View where AccessoryView: View {
    
    // MARK: Data In
    let code: Code
    
    let onTap: ((Int) -> Void)?
    
    let accessoryView: AccessoryView
    
    init(
        code: Code,
        onTap: ((Int) -> Void)? = nil,
        @ViewBuilder accessoryView: @escaping () -> AccessoryView = { EmptyView() }
    ) {
        self.code = code
        self.onTap = onTap
        self.accessoryView = accessoryView()
    }

    // MARK: - Body
    var body: some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .overlay {
                        if code.pegs[index] == Code.missing {
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.gray)
                        }
                    }
                    .contentShape(Rectangle())
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(code.pegs[index].toColor ?? Color.clear)
                    .overlay { showTextView(for: code.pegs[index]) }
                    .onTapGesture {
                        onTap?(index)
                    }
                    .opacity(code.kind == .master ? 0 : 1)
            }
            
            MatchMarkers(matches: code.matches)
                .overlay {
                    accessoryView
                }
        }
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

extension String {
    var toColor: Color? {
        switch self {
        case "red": .red
        case "green": .green
        case "blue": .blue
        case "yellow": .yellow
        case "clear": .clear

        default: nil
        }
    }
}
