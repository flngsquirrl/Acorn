//
// SegmentedFilterView.swift
// Acorn
//
// Created by flngsquirrl on 13/02/2025.
import SwiftUI

struct SegmentedFilterView: View {
    let filterModel: FilterModel

    var body: some View {
        HStack {
            ForEach(FilterOption.allCases, id: \.self) { option in
                let isSelected = filterModel.isSelected(option)
                FilterOptionView(label: option.rawValue, isSelected: isSelected)
                    .onTapGesture {
                        withAnimation {
                            filterModel.toggle(option)
                        }
                    }
            }
        }
    }
}

#if DEBUG
    struct SegmentedFilterPreview: View {
        var body: some View {
            SegmentedFilterView(filterModel: FilterModel())
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background(
                    Rectangle()
                        .fill(.background.secondary)
                )
        }
    }
#endif

#Preview("SegmentedFilterView: PL", traits: .sizeThatFitsLayout) {
    SegmentedFilterPreview()
        .environment(\.locale, Locale(identifier: "pl"))
}

#Preview("SegmentedFilterView: EN", traits: .sizeThatFitsLayout) {
    SegmentedFilterPreview()
}
