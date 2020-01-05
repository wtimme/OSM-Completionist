//
//  QuestListUITestCase.swift
//  GoMapUITests
//
//  Created by Wolfgang Timme on 1/4/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import XCTest

class QuestListUITestCase: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }
    
    override func tearDown() {
        app.terminate()
        app = nil
    }
    
    func testTapOnQuestsMenuItemInDisplayOptionsShouldShowQuestListViewController() {
        goToQuestListViewController()
        
        snapshot("02QuestList")
    }
    
    func testQuestList_shouldNotBeEmpty() {
        goToQuestListViewController()
        
        XCTAssert(app.tables.children(matching: .cell).count > 0)
    }
    
    // MARK: Helper methods
    
    private func goToQuestListViewController() {
        let button = app.buttons["display_options_button"]
        button.press(forDuration: 1.0)
        
        waitForViewController("Display")
        
        app.cells["quests"].tap()
        
        waitForViewController("Quests")
    }

}
