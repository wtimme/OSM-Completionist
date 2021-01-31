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
    var delegateMock: QuestListViewModelDelegateMock!

    override func setUp() {
        super.setUp()

        questProviderMock = QuestProviderMock()
        viewModel = QuestListViewModel(questProvider: questProviderMock)

        delegateMock = QuestListViewModelDelegateMock()
        viewModel.delegate = delegateMock
    }

    override func tearDown() {
        viewModel = nil
        questProviderMock = nil
        delegateMock = nil

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

    func testItemAtIndex_whenProvidedWithAValidIndex_shouldReturnItemWithTheIconImageNameAsTheImageName() {
        let iconImageName = "ic_quest_foobar"
        questProviderMock.quests = [Quest.makeQuest(iconImageName: iconImageName)]

        let item = viewModel.item(at: 0)
        XCTAssertEqual(item?.imageName, iconImageName)
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

    func testItemAtIndex_whenProvidedWithAValidIndex_shouldReturnItemWithAccessoryNoneIfQuestWasNotActive() {
        questProviderMock.quests = [Quest.makeQuest()]

        /// Act as if the quest was not active.
        questProviderMock.isQuestActiveMockedReturnValue = false

        let item = viewModel.item(at: 0)
        XCTAssertEqual(item?.accessory, QuestListViewModel.Item.Accessory.none)
    }

    func testItemAtIndex_whenProvidedWithAValidIndex_shouldReturnItemWithAccessoryCheckmarkIfQuestWasActive() {
        questProviderMock.quests = [Quest.makeQuest()]

        /// Act as if the quest was not active.
        questProviderMock.isQuestActiveMockedReturnValue = true

        let item = viewModel.item(at: 0)
        XCTAssertEqual(item?.accessory, QuestListViewModel.Item.Accessory.checkmark)
    }

    // MARK: selectItem(at:)

    func testSelectItemAtIndex_whenProvidedWithANegativeIndex_shouldNotCallQuestProvider() {
        viewModel.selectItem(at: -1)

        XCTAssertFalse(questProviderMock.activateQuestCalled)
        XCTAssertFalse(questProviderMock.deactivateQuestCalled)
    }

    func testSelectItemAtIndex_whenProvidedWithAnIndexThatIsOutOfRange_shouldNotCallQuestProvider() {
        questProviderMock.quests = [Quest.makeQuest()]

        viewModel.selectItem(at: 42)

        XCTAssertFalse(questProviderMock.activateQuestCalled)
        XCTAssertFalse(questProviderMock.deactivateQuestCalled)
    }

    func testSelectItemAtIndex_whenProvidedWithAValidIndex_shouldAskDelegateToReloadTheItemAtThatPath() {
        let firstQuest = Quest.makeQuest()
        let secondQuest = Quest.makeQuest()
        questProviderMock.quests = [firstQuest, secondQuest]

        let itemIndex = 1
        viewModel.selectItem(at: itemIndex)

        XCTAssertTrue(delegateMock.reloadItemCalled)
        XCTAssertEqual(delegateMock.reloadItemIndex, itemIndex)
    }

    func testSelectItemAtIndex_whenProvidedWithAValidIndex_shouldAskQuestProviderIfTheQuestAtTheGivenIndexWasActive() {
        let firstQuest = Quest.makeQuest()
        let secondQuest = Quest.makeQuest()
        questProviderMock.quests = [firstQuest, secondQuest]

        viewModel.selectItem(at: 1)

        XCTAssertEqual(questProviderMock.isQuestActiveQuest?.identifier,
                       secondQuest.identifier, "The view model should ask the quest provider if that particular quest was active")
    }

    func testSelectItemAtIndex_whenProvidedWithAValidIndexThatTheQuestProviderReportedAsNotActive_shouldAskQuestProviderToActivateTheQuest() {
        questProviderMock.quests = [Quest.makeQuest()]
        questProviderMock.isQuestActiveMockedReturnValue = false

        viewModel.selectItem(at: 0)

        XCTAssertTrue(questProviderMock.activateQuestCalled)
    }

    func testSelectItemAtIndex_whenProvidedWithAValidIndexThatTheQuestProviderReportedAsNotActive_shouldAskQuestProviderToActivateThatParticularQuest() {
        let firstQuest = Quest.makeQuest()
        let secondQuest = Quest.makeQuest()
        questProviderMock.quests = [firstQuest, secondQuest]
        questProviderMock.isQuestActiveMockedReturnValue = false

        viewModel.selectItem(at: 1)

        XCTAssertEqual(questProviderMock.activateQuestQuest?.identifier, secondQuest.identifier)
    }

    func testSelectItemAtIndex_whenProvidedWithAValidIndexThatTheQuestProviderReportedAsActive_shouldAskQuestProviderToDeactivateTheQuest() {
        questProviderMock.quests = [Quest.makeQuest()]
        questProviderMock.isQuestActiveMockedReturnValue = true

        viewModel.selectItem(at: 0)

        XCTAssertTrue(questProviderMock.deactivateQuestCalled)
    }

    func testSelectItemAtIndex_whenProvidedWithAValidIndexThatTheQuestProviderReportedAsActive_shouldAskQuestProviderToDeactivateThatParticularQuest() {
        let firstQuest = Quest.makeQuest()
        let secondQuest = Quest.makeQuest()
        questProviderMock.quests = [firstQuest, secondQuest]
        questProviderMock.isQuestActiveMockedReturnValue = true

        viewModel.selectItem(at: 1)

        XCTAssertEqual(questProviderMock.deactivateQuestQuest?.identifier, secondQuest.identifier)
    }
}
