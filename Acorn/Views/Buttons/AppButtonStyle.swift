//
// AppButtonStyle.swift
// Acorn
//
// Created by flngsquirrl on 20/02/2025.

import SwiftUI

struct AppButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.8 : 1)
    }
}

extension ButtonStyle where Self == AppButtonStyle {
    static var appButton: AppButtonStyle {
        AppButtonStyle()
    }
}
