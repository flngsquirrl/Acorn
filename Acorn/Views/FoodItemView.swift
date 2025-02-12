//
// FoodItemView.swift
// Acorn
//
// Created by flngsquirrl on 11/02/2025.

import SwiftUI

struct FoodItemView: View {
    let item: FoodItem

    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                    .lineLimit(1)

                Text(expirationNote)
                    .font(.caption)
            }
            Spacer()

            if showWarning {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundStyle(warningColor)
                    .font(.title)
                    .padding(.trailing)
            }
        }
    }

    var expirationNote: String {
        switch item.state {
        case let .good(days):
            days > 5 ?
                "Good for \(days) days" :
                "Expires in \(days) days"
        case let .bad(days):
            "Expired \(days) days ago"
        }
    }

    var showWarning: Bool {
        switch item.state {
        case let .good(days):
            days < 5
        case .bad:
            true
        }
    }

    var warningColor: Color {
        switch item.state {
        case .good: .yellow
        case .bad: .red
        }
    }
}

#Preview {
    Group {
        FoodItemView(item: FoodItem.badMocarella)
        FoodItemView(item: FoodItem.goodTofu)
        FoodItemView(item: FoodItem.expiringJogurt)
        FoodItemView(item: FoodItem(name: "Some specific item with a very long name", goodUntil: Date.now))
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding()
    .border(.secondary, width: 2)
}
