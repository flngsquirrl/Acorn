//
// View+ButtonLabel.swift
// Acorn
//
// Created by flngsquirrl on 04/03/2025.

import SwiftUI

struct ButtonLabelModifier: ViewModifier {
    let accented: Bool

    init(accented: Bool = true) {
        self.accented = accented
    }

    func body(content: Content) -> some View {
        content
            .bold()
            .padding()
            .background(
                Rectangle()
                    .fill(accented ? .accent : .clear)
                    .border(.primary, width: accented ? 0 : 2))
            .foregroundStyle(accented ? .white : .primary)
    }
}

extension View {
    func buttonLabel(accented: Bool = true) -> some View {
        modifier(ButtonLabelModifier(accented: accented))
    }
}

#Preview {
    VStack {
        Button {} label: {
            Label("Add item", systemImage: "plus")
                .buttonLabel()
        }

        Button {} label: {
            Text("Cancel")
                .buttonLabel(accented: false)
        }

        Button {} label: {
            Text("Save")
                .frame(maxWidth: .infinity)
                .buttonLabel()
        }

        Button {} label: {
            Text("Cancel")
                .frame(maxWidth: .infinity)
                .buttonLabel(accented: false)
        }
    }
}
