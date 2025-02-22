//
// XCUITest.swift
// Acorn
//
// Created by flngsquirrl on 22/02/2025.

import XCTest

@MainActor
class XCUITest: XCTestCase {
    var app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launch()
    }
}
