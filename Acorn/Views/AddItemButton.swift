//
// AddItemButton.swift
// Acorn
//
// Created by flngsquirrl on 16/02/2025.

import SwiftUI

struct AddItemButton: View {
    var body: some View {
        Button {} label: {
            Label("list.addItem.button", systemImage: "plus")
                .bold()
                .padding()
                .background(
                    Rectangle()
                        .fill(Color.accentColor)
                )
                .foregroundStyle(.white)
        }
        .buttonStyle(.appButton)
    }
}

#Preview {
    AddItemButton()
}
