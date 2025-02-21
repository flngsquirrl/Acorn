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
            .bold()
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(
                Rectangle()
                    .strokeBorder(lineWidth: 1)
                    .fill(isSelected ? .accent : .clear)
            )
            .foregroundStyle(isSelected ? .white : .primary.opacity(0.7))
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
