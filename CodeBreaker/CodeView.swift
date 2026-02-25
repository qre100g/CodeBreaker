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
    
    @Binding var selection: Int
    
    let accessoryView: AccessoryView
    
    init(
        code: Code,
        selection: Binding<Int> = .constant(-1),
        @ViewBuilder accessoryView: @escaping () -> AccessoryView = { EmptyView() }
    ) {
        self.code = code
        self._selection = selection
        self.accessoryView = accessoryView()
    }

    // MARK: - Body
    var body: some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self) { index in
                PegView(peg: code.pegs[index])
                    .overlay {
                        if selection == index || code.kind == .master {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Color.gray.opacity(code.kind == .master ? 1 : 0.5))
                        }
                    }
                    .onTapGesture {
                        selection = index
                    }
            }
            
            MatchMarkers(matches: code.matches)
                .overlay {
                    accessoryView
                }
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
