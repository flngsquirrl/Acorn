//
// FoodItemDetailsView.swift
// Acorn
//
// Created by flngsquirrl on 28/02/2025.

import SwiftUI

struct FoodItemDetailsView: View {
    @Environment(\.dismiss) var dismiss

    let item: FoodItem

    var body: some View {
        Text(item.name)
            .navigationBarBackButtonHidden()
            .navigationTitle("item.details.title")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    backButton
                }
            }
    }
}

extension FoodItemDetailsView {
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

#Preview {
    NavigationStack {
        FoodItemDetailsView(item: FoodItem.badMocarella)
    }
}
