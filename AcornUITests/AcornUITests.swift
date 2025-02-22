//
// AcornUITests.swift
// Acorn
//
// Created by flngsquirrl on 22/02/2025.

import XCTest

final class AcornUITests: XCUITest {
    func testDetailsView() {
        let allStaticText = app.staticTexts["filter.all.access"]
        XCTAssertTrue(allStaticText.exists)
    }
}
