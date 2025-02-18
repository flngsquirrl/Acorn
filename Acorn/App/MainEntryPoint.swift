//
// MainEntryPoint.swift
// Acorn
//
// Created by flngsquirrl on 18/02/2025.
import SwiftUI

@main
struct MainEntryPoint {
    static func main() {
        guard isProduction() else {
            TestApp.main()
            return
        }

        AcornApp.main()
    }

    private static func isProduction() -> Bool {
        NSClassFromString("XCTestCase") == nil
    }
}
