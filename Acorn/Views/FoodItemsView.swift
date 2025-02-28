//
// FoodItemsView.swift
// Acorn
//
// Created by flngsquirrl on 12/02/2025.

import SwiftUI

struct FoodItemsView: View {
    @State private var items = FoodItem.examples
    @State private var filterModel = AppFilterModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                filter
                list
                    .safeAreaInset(edge: .bottom, alignment: .trailing) {
                        addItemButton
                    }
            }
            .navigationTitle("list.title")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

extension FoodItemsView {
    var filter: some View {
        SegmentedFilterView(filterModel: filterModel)
            .padding(.vertical, 10)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.background.secondary)
    }

    var list: some View {
        ScrollView {
            VStack {
                ForEach(items) {
                    FoodItemView(item: $0)
                        .background(.background.secondary)
                        .padding(.horizontal)
                }
            }
        }
        .background(.background.secondary)
    }

    var addItemButton: some View {
        AddItemButton()
            .padding([.bottom, .trailing])
            .padding(.top, 20)
    }
}

#Preview("FoodItemsView: EN") {
    FoodItemsView()
}

#Preview("FoodItemsView: PL") {
    FoodItemsView()
        .environment(\.locale, Locale(identifier: "pl"))
}
