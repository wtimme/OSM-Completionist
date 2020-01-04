//
//  QuestListViewModelTestCase.swift
//  GoMapTests
//
//  Created by Wolfgang Timme on 1/4/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import XCTest

@testable import Go_Map__

class QuestListViewModelTestCase: XCTestCase {
    
    var viewModel: QuestListViewModel!
    var questProviderMock: QuestProviderMock!

    override func setUp() {
        super.setUp()
        
        questProviderMock = QuestProviderMock()
        viewModel = QuestListViewModel(questProvider: questProviderMock)
    }

    override func tearDown() {
        viewModel = nil
        questProviderMock = nil
        
        super.tearDown()
    }
    
    // MARK: numberOfItems
    
    func testNumberOfItems_shouldMatchTheNumberOfQuests() {
        questProviderMock.quests = []
        XCTAssertEqual(viewModel.numberOfItems(), 0)
        
        questProviderMock.quests = [Quest.makeQuest(), Quest.makeQuest()]
        XCTAssertEqual(viewModel.numberOfItems(), 2)
    }
    
    // MARK: item(at:)
    
    func testItemAtIndex_whenProvidedWithNegativeIndex_shouldReturnNil() {
        XCTAssertNil(viewModel.item(at: -1))
    }
    
    func testItemAtIndex_whenProvidedWithAnIndexThatIsOutOfRange_shouldReturnNil() {
        questProviderMock.quests = [Quest.makeQuest()]
        
        XCTAssertNil(viewModel.item(at: 42))
    }
    
    func testItemAtIndex_whenProvidedWithAValidIndex_shouldReturnItemWithTheQuestQuestionAsTitle() {
        let question = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        questProviderMock.quests = [Quest.makeQuest(question: question)]
        
        let item = viewModel.item(at: 0)
        XCTAssertEqual(item?.title, question)
    }
    
    func testItemAtIndex_whenProvidedWithAValidIndex_shouldReturnItemWithTheQuestQueryAsSubtitle() {
        let overpassWizardQuery = "type:node"
        questProviderMock.quests = [Quest.makeQuest(overpassWizardQuery: overpassWizardQuery)]
        
        let item = viewModel.item(at: 0)
        XCTAssertEqual(item?.subtitle, overpassWizardQuery)
    }
    
    func testItemAtIndex_whenProvidedWithAValidIndex_shouldAskQuestProviderIfQuestWasActive() {
        let quest = Quest.makeQuest()
        questProviderMock.quests = [quest]
        
        _ = viewModel.item(at: 0)
        
        XCTAssertTrue(questProviderMock.isQuestActiveCalled)
    }
    
    func testItemAtIndex_whenProvidedWithAValidIndex_shouldAskQuestProviderIfTheQuestAtTheGivenIndexWasActive() {
        let firstQuest = Quest.makeQuest()
        let secondQuest = Quest.makeQuest()
        questProviderMock.quests = [firstQuest, secondQuest]
        
        _ = viewModel.item(at: 1)
        
        XCTAssertEqual(questProviderMock.isQuestActiveQuest?.identifier,
                       secondQuest.identifier, "The view model should ask the quest provider if that particular quest was active")
    }

}
