//
// AppButtonStyle.swift
// Acorn
//
// Created by flngsquirrl on 20/02/2025.

import SwiftUI

struct AppButtonStyle<LabelModifier>: ButtonStyle where LabelModifier: ViewModifier {
    var labelModifier: LabelModifier

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .modifier(labelModifier)
            .opacity(configuration.isPressed ? 0.8 : 1)
    }
}

extension ButtonStyle where Self == AppButtonStyle<ButtonLabelModifier> {
    static var primary: AppButtonStyle<ButtonLabelModifier> {
        AppButtonStyle(labelModifier: ButtonLabelModifier())
    }

    static var secondary: AppButtonStyle<ButtonLabelModifier> {
        AppButtonStyle(labelModifier: ButtonLabelModifier(accented: false))
    }

    static var support: AppButtonStyle<ButtonLabelModifier> {
        AppButtonStyle(labelModifier: ButtonLabelModifier(accented: false))
    }
}

#Preview {
    VStack {
        Button {} label: {
            Label("Add item", systemImage: "plus")
        }
        .buttonStyle(.primary)

        Button {} label: {
            Text("Cancel")
        }
        .buttonStyle(.secondary)

        Button {} label: {
            Text("Save")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.primary)

        Button {} label: {
            Text("Cancel")
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.secondary)
    }
}
