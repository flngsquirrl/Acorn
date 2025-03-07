//
// FoodItemView.swift
// Acorn
//
// Created by flngsquirrl on 11/02/2025.

import SwiftUI

struct FoodItemView: View {
    let item: FoodItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                    .lineLimit(1)
                    .padding(.bottom)

                HStack(alignment: .top) {
                    Text(expirationNote)

                    Spacer()

                    if let actionIconName {
                        Image(systemName: actionIconName)
                    }
                }
                .font(.caption)
            }
            .padding(.leading)
            .padding()
        }
        .background(alignment: .leading) {
            Rectangle()
                .fill(itemColor)
                .frame(width: 10)
        }
    }

    var expirationNote: LocalizedStringKey {
        switch item.state {
            case let .good(days):
                days > 5 ?
                    "list.item.goodFor\(days)" :
                    "list.item.expiresIn\(days)"
            case let .bad(days):
                "list.item.expired\(days)"
        }
    }

    func isExpiring(item: FoodItem) -> Bool {
        if case let .good(days) = item.state, days < 5 {
            return true
        }

        return false
    }

    var actionIconName: String? {
        switch item.state {
            case .good:
                isExpiring(item: item) ? "exclamationmark.triangle" : nil
            case .bad:
                "trash"
        }
    }

    var itemColor: Color {
        switch item.state {
            case .good:
                isExpiring(item: item) ? .yellow : .green
            case .bad: .red
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let itemWithLongName = FoodItem(
        name: "Some item with a very very very very very long name",
        goodUntil: Calendar.current.date(byAdding: .day, value: 10, to: Date.now)!
    )

    static let itemExpiredYesterday = FoodItem(
        name: "Item expired yesterday",
        goodUntil: Calendar.current.date(byAdding: .day, value: -1, to: Date.now)!
    )

    static let itemExpiresToday = FoodItem(name: "Item expires today", goodUntil: Date.now)

    static var previews: some View {
        ForEach(Bundle.main.localizations, id: \.self) { localization in
            VStack {
                Group {
                    FoodItemView(item: FoodItem.badMocarella)
                    FoodItemView(item: FoodItem.goodTofu)
                    FoodItemView(item: FoodItem.expiringJogurt)
                    FoodItemView(item: itemWithLongName)
                    FoodItemView(item: itemExpiredYesterday)
                    FoodItemView(item: itemExpiresToday)
                }
                .border(.secondary, width: 2)
            }
            .environment(\.locale, .init(identifier: localization))
            .previewDisplayName("FoodItemView: \(localization.uppercased())")
        }
    }
}
