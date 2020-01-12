//
//  MapViewViewModelTestCase.swift
//  GoMapTests
//
//  Created by Wolfgang Timme on 1/11/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import XCTest
@testable import Go_Map__

class MapViewViewModelTestCase: XCTestCase {
    
    var viewModel: MapViewViewModel!
    var activeQuestBaseObjectMatcherMock: ActiveQuestBaseObjectMatcherMock!
    
    override func setUp() {
        super.setUp()
        
        activeQuestBaseObjectMatcherMock = ActiveQuestBaseObjectMatcherMock()
        viewModel = MapViewViewModel(activeQuestBaseObjectMatcher: activeQuestBaseObjectMatcherMock)
    }

    override func tearDown() {
        viewModel = nil
        activeQuestBaseObjectMatcherMock = nil
        
        super.tearDown()
    }
    
    // MARK: presentQuestInterface(for:)
    
    func testPresentQuestInterface_whenInvoked_shouldAskActiveQuestBaseObjectMatcherUsingTheGivenBaseObject() {
        /// Given
        let baseObject = OsmBaseObject()
        activeQuestBaseObjectMatcherMock.questsToReturn = []
        
        /// When
        _ = viewModel.presentQuestInterface(for: baseObject)
        
        /// Then
        XCTAssertEqual(activeQuestBaseObjectMatcherMock.baseObject, baseObject)
    }
    
    func testPresentQuestInterface_whenBaseObjectDoesNotMatchAnyQuest_shouldReturnFalse() {
        /// Given
        activeQuestBaseObjectMatcherMock.questsToReturn = []
        
        /// Then
        XCTAssertFalse(viewModel.presentQuestInterface(for: OsmBaseObject()))
    }
    
    func testPresentQuestInterface_whenBaseObjectDoesMatchAQuest_shouldReturnTrue() {
        /// Given
        activeQuestBaseObjectMatcherMock.questsToReturn = [Quest.makeQuest()]
        
        /// Then
        XCTAssertTrue(viewModel.presentQuestInterface(for: OsmBaseObject()))
    }

}
