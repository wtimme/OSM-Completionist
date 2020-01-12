//
//  MapViewModelTestCase.swift
//  GoMapTests
//
//  Created by Wolfgang Timme on 1/11/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import XCTest
@testable import Go_Map__

class MapViewModelTestCase: XCTestCase {
    
    var viewModel: MapViewModel!
    var activeQuestBaseObjectMatcherMock: ActiveQuestBaseObjectMatcherMock!
    var delegateMock: MapViewModelDelegateMock!
    
    override func setUp() {
        super.setUp()
        
        activeQuestBaseObjectMatcherMock = ActiveQuestBaseObjectMatcherMock()
        viewModel = MapViewModel(activeQuestBaseObjectMatcher: activeQuestBaseObjectMatcherMock)
        
        delegateMock = MapViewModelDelegateMock()
        viewModel.delegate = delegateMock
    }

    override func tearDown() {
        viewModel = nil
        activeQuestBaseObjectMatcherMock = nil
        delegateMock = nil
        
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
    
    func testPresentQuestInterface_whenBaseObjectDoesMatchQuests_shouldTellDelegateToAskTheQuestionOfFirstQuest() {
        /// Given
        let firstQuestion = "Does this bench have a backrest?"
        let secondQuestion = "Are these toilets wheelchair accessible?"
        activeQuestBaseObjectMatcherMock.questsToReturn = [Quest.makeQuest(question: firstQuestion),
                                                           Quest.makeQuest(question: secondQuestion)]
        
        /// When
        _ = viewModel.presentQuestInterface(for: OsmBaseObject())
        
        /// Then
        XCTAssertEqual(delegateMock.question, firstQuestion)
    }
    
    func testPresentQuestInterface_whenBaseObjectDoesMatchQuests_shouldTellDelegateToProvideTheChoicesFromFirstQuest() {
        /// Given
        let firstAnswer = Quest.Answer(title: "Yes", key: "backrest", value: "true")
        let secondAnswer = Quest.Answer(title: "No", key: "backrest", value: "false")
        activeQuestBaseObjectMatcherMock.questsToReturn = [Quest.makeQuest(answers: [firstAnswer, secondAnswer])]
        
        /// When
        _ = viewModel.presentQuestInterface(for: OsmBaseObject())
        
        /// Then
        XCTAssertEqual(delegateMock.choices, ["Yes (backrest=true)", "No (backrest=false)"])
    }
    
    func testPresentQuestInterface_whenExecutingSelectionHandlerWithInvalidIndex_shouldNotCallFinishQuest() {
        /// Given
        activeQuestBaseObjectMatcherMock.questsToReturn = [Quest.makeQuest()]
        
        /// When
        _ = viewModel.presentQuestInterface(for: OsmBaseObject())
        delegateMock.selectionHandler?(999)
        
        /// Then
        XCTAssertFalse(delegateMock.didCallFinishQuest)
    }
    
    func testPresentQuestInterface_whenExecutingSelectionHandlerWithValidIndex_shouldAskDelegateToFinishQuest() {
        /// Given
        let key = "backrest"
        let value = "true"
        let answer = Quest.Answer(title: "", key: key, value: value)
        activeQuestBaseObjectMatcherMock.questsToReturn = [Quest.makeQuest(answers: [answer])]
        
        /// When
        _ = viewModel.presentQuestInterface(for: OsmBaseObject())
        delegateMock.selectionHandler?(0)
        
        /// Then
        XCTAssertTrue(delegateMock.didCallFinishQuest)
        XCTAssertEqual(delegateMock.didFinishQuestTag?.0, key)
        XCTAssertEqual(delegateMock.didFinishQuestTag?.1, value)
    }

}
