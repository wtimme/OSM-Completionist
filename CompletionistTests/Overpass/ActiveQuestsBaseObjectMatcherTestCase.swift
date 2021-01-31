//
//  ActiveQuestsBaseObjectMatcherTestCase.swift
//  GoMapTests
//
//  Created by Wolfgang Timme on 1/11/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

@testable import Go_Map__
import XCTest

class ActiveQuestsBaseObjectMatcherTestCase: XCTestCase {
    var questProviderMock: QuestProviderMock!
    var matcher: ActiveQuestBaseObjectMatching!

    override func setUp() {
        super.setUp()

        questProviderMock = QuestProviderMock()
        matcher = ActiveQuestsBaseObjectMatcher(questProvider: questProviderMock)
    }

    override func tearDown() {
        matcher = nil
        questProviderMock = nil

        super.tearDown()
    }

    func testQuestsMatchingBaseObject_whenThereAreNoActiveQuests_shouldReturnEmptyList() {
        /// Given
        questProviderMock.activeQuests = []

        /// Then
        XCTAssertTrue(matcher.quests(matching: OsmBaseObject()).isEmpty)
    }

    func testQuestsMatchingBaseObject_whenQuestDoesNotHaveABaseObjectMatcher_shouldReturnEmptyList() {
        /// Given
        questProviderMock.activeQuests = [Quest.makeQuest(baseObjectMatcher: nil)]

        /// Then
        XCTAssertTrue(matcher.quests(matching: OsmBaseObject()).isEmpty)
    }

    func testQuestsMatchingBaseObject_shouldReturnAllActiveQuestThatMatch() {
        /// Given
        let firstQuest = Quest.makeQuest(baseObjectMatcher: BaseObjectMatcherMock(doesMatch: true))
        let secondQuest = Quest.makeQuest(baseObjectMatcher: BaseObjectMatcherMock(doesMatch: true))
        questProviderMock.activeQuests = [firstQuest, secondQuest]

        /// Then
        XCTAssertEqual(matcher.quests(matching: OsmBaseObject()).map { $0.identifier },
                       [firstQuest, secondQuest].map { $0.identifier })
    }

    func testQuestsMatchingBaseObject_shouldNotReturnActiveQuestThatDoNotMatch() {
        /// Given
        let firstQuest = Quest.makeQuest(baseObjectMatcher: BaseObjectMatcherMock(doesMatch: false))
        let secondQuest = Quest.makeQuest(baseObjectMatcher: BaseObjectMatcherMock(doesMatch: true))
        questProviderMock.activeQuests = [firstQuest, secondQuest]

        /// Then
        XCTAssertEqual(matcher.quests(matching: OsmBaseObject()).map { $0.identifier },
                       [secondQuest].map { $0.identifier })
    }

    func testQuestsMatchingBaseObject_shouldAskAllMatchersIfTheyMatchWithBaseObject() {
        /// Given
        let baseObject = OsmBaseObject()
        let firstBaseObjectMatcherMock = BaseObjectMatcherMock()
        let secondBaseObjectMatcherMock = BaseObjectMatcherMock()
        questProviderMock.activeQuests = [Quest.makeQuest(baseObjectMatcher: firstBaseObjectMatcherMock),
                                          Quest.makeQuest(baseObjectMatcher: secondBaseObjectMatcherMock)]

        /// When
        _ = matcher.quests(matching: baseObject)

        /// Then
        XCTAssertEqual(firstBaseObjectMatcherMock.object, baseObject)
        XCTAssertEqual(secondBaseObjectMatcherMock.object, baseObject)
    }
}
