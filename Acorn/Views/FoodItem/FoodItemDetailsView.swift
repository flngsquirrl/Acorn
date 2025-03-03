//
// FoodItemDetailsView.swift
// Acorn
//
// Created by flngsquirrl on 28/02/2025.

import SwiftUI

struct FoodItemDetailsView: View {
    let item: FoodItem

    var body: some View {
        Text(item.name)
            .navigationTitle("item.details.title")
            .navigationBarTitleDisplayMode(.inline)
            .withCustomNavigationBackButton()
    }
}

#Preview {
    NavigationStack {
        FoodItemDetailsView(item: FoodItem.badMocarella)
    }
}
