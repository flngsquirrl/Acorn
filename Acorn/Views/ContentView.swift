//
// ContentView.swift
// Acorn
//
// Created by flngsquirrl on 11/02/2025.

import SwiftUI

struct ContentView: View {
    @State private var dataSource = AppFoodItemsDataSource()
    @State private var filterModel = AppFilterModel()

    var body: some View {
        FoodItemsView(dataSource: dataSource, filterModel: filterModel)
    }
}

#Preview {
    ContentView()
}
