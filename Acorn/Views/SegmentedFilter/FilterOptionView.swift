//
// FilterOptionView.swift
// Acorn
//
// Created by flngsquirrl on 14/02/2025.
import SwiftUI

struct FilterOptionView: View {
    let label: String
    let isSelected: Bool

    var localizedLabel: LocalizedStringKey {
        LocalizedStringKey(label)
    }

    var body: some View {
        Text(localizedLabel)
            .font(.footnote)
            .padding(.vertical, 6)
            .padding(.horizontal)
            .background(
                Rectangle()
                    .strokeBorder(lineWidth: isSelected ? 0 : 1)
                    .fill(isSelected ? Color.primary : .clear)
            )
            .foregroundStyle(isSelected ? Color.background : .primary)
            .minHitTarget()
            .contentShape(Rectangle())
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    HStack {
        FilterOptionView(label: "Good", isSelected: true)
        FilterOptionView(label: "Bad", isSelected: false)
    }
    .padding()
}
