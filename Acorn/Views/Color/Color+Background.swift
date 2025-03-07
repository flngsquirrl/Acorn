//
// Color+Background.swift
// Acorn
//
// Created by flngsquirrl on 01/03/2025.

import SwiftUI

extension Color {
    static let background = Color(UIColor.systemBackground)
}

#Preview {
    Rectangle()
        .fill(Color.background)
        .frame(width: 100, height: 100)
        .border(.red, width: 2)
}
