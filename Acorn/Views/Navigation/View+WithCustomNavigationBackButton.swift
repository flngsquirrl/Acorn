//
// View+WithCustomNavigationBackButton.swift
// Acorn
//
// Created by flngsquirrl on 03/03/2025.

import SwiftUI

struct CustomNavigationBackButtonModifier: ViewModifier {
    @Environment(\.dismiss) private var dismiss

    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    backButton
                }
            }
    }

    var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "arrow.turn.up.left")
                .font(.caption)
                .minHitTarget()
        }
        .tint(.primary)
    }
}

extension View {
    func withCustomNavigationBackButton() -> some View {
        modifier(CustomNavigationBackButtonModifier())
    }
}
