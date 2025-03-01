//
// FoodItemsView.swift
// Acorn
//
// Created by flngsquirrl on 12/02/2025.

import SwiftUI

struct FoodItemsView: View {
    var dataSource: any FoodItemsDataSource
    var filterModel: FilterModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                filter
                list
                    .safeAreaInset(edge: .bottom, alignment: .trailing) {
                        addItemButton
                    }
            }
            .navigationDestination(for: UUID.self) { id in
                if let item = dataSource.get(id: id) {
                    FoodItemDetailsView(item: item)
                }
            }
        }
    }
}

extension FoodItemsView {
    var filter: some View {
        SegmentedFilterView(filterModel: filterModel)
            .padding(.vertical, 10)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .background(.background.secondary)
    }

    var list: some View {
        ScrollView {
            VStack {
                ForEach(dataSource.items) { item in
                    NavigationLink(value: item.id) {
                        FoodItemView(item: item)
                            .background(.background.secondary)
                            .padding(.horizontal)
                    }
                    .tint(.primary)
                }
            }
        }
        .task {
            await dataSource.load()
        }
        .scrollIndicators(.hidden)
        .background(.background.secondary)
    }

    var addItemButton: some View {
        AddItemButton()
            .padding([.bottom, .trailing])
            .padding(.top, 20)
    }
}

#Preview("FoodItemsView: EN") {
    FoodItemsView(dataSource: ExampleFoodItemsDataSource(),
                  filterModel: AppFilterModel())
}

// #Preview("FoodItemsView: PL") {
//    FoodItemsView(dataSource: ExampleFoodItemsDataSource(),
//                  filterModel: AppFilterModel())
//        .environment(\.locale, Locale(identifier: "pl"))
// }
