//
//  StaticQuestProviderTestCase.swift
//  GoMapTests
//
//  Created by Wolfgang Timme on 1/4/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import XCTest

@testable import Go_Map__

class StaticQuestProviderTestCase: XCTestCase {
    var questProvider: QuestProviding!

    var userDefaults: UserDefaults!
    let userDefaultsSuiteName = "TestDefaults"
    let activeQuestIdentifierUserDefaultsKey = "identifiers"
    var notificationCenter: NotificationCenter!

    override func setUp() {
        super.setUp()

        UserDefaults().removePersistentDomain(forName: userDefaultsSuiteName)
        userDefaults = UserDefaults(suiteName: userDefaultsSuiteName)

        notificationCenter = NotificationCenter()

        setupQuestProvider()
    }

    override func tearDown() {
        questProvider = nil
        userDefaults = nil
        notificationCenter = nil

        super.tearDown()
    }

    // MARK: Helper methods

    private func setupQuestProvider(quests: [Quest] = [Quest.makeQuest()]) {
        questProvider = StaticQuestProvider(quests: quests,
                                            userDefaults: userDefaults,
                                            activeQuestIdentifierUserDefaultsKey: activeQuestIdentifierUserDefaultsKey,
                                            notificationCenter: notificationCenter)
    }

    // MARK: activeQuests

    func testActiveQuests_whenQuestIdentifierIsStoredInUserDefaults_shouldReturnQuest() {
        /// Given
        let questIdentifier = "lorem_ipsum"
        let quest = Quest.makeQuest(identifier: questIdentifier)

        setupQuestProvider(quests: [quest])

        /// When
        userDefaults.set([questIdentifier], forKey: activeQuestIdentifierUserDefaultsKey)

        /// Then
        XCTAssertTrue(questProvider.activeQuests.contains(where: { $0.identifier == questIdentifier }))
    }

    func testActiveQuests_whenQuestIdentifierIsNotStoredInUserDefaults_shouldNotReturnQuest() {
        /// Given
        let questIdentifier = "lorem_ipsum"
        let quest = Quest.makeQuest(identifier: questIdentifier)

        setupQuestProvider(quests: [quest])

        /// When
        userDefaults.set([], forKey: activeQuestIdentifierUserDefaultsKey)

        /// Then
        XCTAssertTrue(questProvider.activeQuests.isEmpty)
    }

    // MARK: isQuestActive(_:)

    func testIsQuestActive_shouldInitiallyReturnFalse() {
        let quest = Quest.makeQuest()
        setupQuestProvider(quests: [quest])

        XCTAssertFalse(questProvider.isQuestActive(quest))
    }

    func testIsQuestActive_whenTheQuestIdentifierIsPartOfTheUserDefaults_shouldReturnTrue() {
        let quest = Quest.makeQuest()
        setupQuestProvider(quests: [quest])

        /// Store the identifier in the `UserDefaults`.
        userDefaults.set([quest.identifier], forKey: activeQuestIdentifierUserDefaultsKey)

        XCTAssertTrue(questProvider.isQuestActive(quest))
    }

    /// This method makes sure that the values are persisted in the `UserDefaults`, and that when a second `StaticQuestProvider` is initialized
    /// with the same `UserDefaults` and the same `activeQuestIdentifierUserDefaultsKey`, a `Quest` is still considered "active".
    func testIsQuestActive_whenUsingTheSameUserDefaultsAndTheSameUserDefaultsKey_shouldStillReturnTrue() {
        let quest = Quest.makeQuest()
        setupQuestProvider(quests: [quest])

        /// Store the identifier in the `UserDefaults`.
        userDefaults.set([quest.identifier], forKey: activeQuestIdentifierUserDefaultsKey)

        /// Create a second `StaticQuestProvider` with the same values.
        let secondQuestProvider = StaticQuestProvider(userDefaults: userDefaults,
                                                      activeQuestIdentifierUserDefaultsKey: activeQuestIdentifierUserDefaultsKey)
        XCTAssertTrue(secondQuestProvider.isQuestActive(quest))
    }

    // MARK: activateQuest(_:)

    func testActiveQuest_shouldStoreQuestIdentifierInUserDefaults() {
        let quest = Quest.makeQuest()
        setupQuestProvider(quests: [quest])

        questProvider.activateQuest(quest)

        guard
            let activeQuestIdentifiers = userDefaults.object(forKey: activeQuestIdentifierUserDefaultsKey) as? [String]
        else {
            XCTFail()
            return
        }

        XCTAssertTrue(activeQuestIdentifiers.contains(quest.identifier))
    }

    func testActiveQuest_shouldStoreQuestIdentifierInUserDefaultsOnlyOnce() {
        let quest = Quest.makeQuest()
        setupQuestProvider(quests: [quest])

        for _ in 1 ... 10 {
            questProvider.activateQuest(quest)
        }

        guard
            let activeQuestIdentifiers = userDefaults.object(forKey: activeQuestIdentifierUserDefaultsKey) as? [String]
        else {
            XCTFail()
            return
        }

        XCTAssertEqual(activeQuestIdentifiers.filter { $0 == quest.identifier }.count, 1)
    }

    func testActivateQuest_whenQuestWasNotActiveBefore_shouldPostNotification() {
        let quest = Quest.makeQuest()
        setupQuestProvider(quests: [quest])

        _ = expectation(forNotification: .QuestManagerDidUpdateActiveQuests,
                        object: questProvider,
                        notificationCenter: notificationCenter)

        questProvider.activateQuest(quest)

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testActivateQuest_whenQuestWasActiveBefore_shouldNotPostNotification() {
        let quest = Quest.makeQuest()
        setupQuestProvider(quests: [quest])

        /// Act as if the quest was active.
        userDefaults.set([quest.identifier], forKey: activeQuestIdentifierUserDefaultsKey)

        let notificationExpectation = expectation(forNotification: .QuestManagerDidUpdateActiveQuests,
                                                  object: questProvider,
                                                  notificationCenter: notificationCenter)
        notificationExpectation.isInverted = true

        questProvider.activateQuest(quest)

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    // MARK: deactivateQuest(_:)

    func testDeactiveQuest_shouldRemoveTheQuestIdentifierFromUserDefaults() {
        let quest = Quest.makeQuest()
        setupQuestProvider(quests: [quest])

        userDefaults.set([quest.identifier], forKey: activeQuestIdentifierUserDefaultsKey)

        questProvider.deactivateQuest(quest)

        guard
            let activeQuestIdentifiers = userDefaults.object(forKey: activeQuestIdentifierUserDefaultsKey) as? [String]
        else {
            XCTFail()
            return
        }

        XCTAssertFalse(activeQuestIdentifiers.contains(quest.identifier))
    }

    func testDeactivateQuest_whenQuestWasActiveBefore_shouldPostNotification() {
        let quest = Quest.makeQuest()
        setupQuestProvider(quests: [quest])

        /// Act as if the quest was active.
        userDefaults.set([quest.identifier], forKey: activeQuestIdentifierUserDefaultsKey)

        _ = expectation(forNotification: .QuestManagerDidUpdateActiveQuests,
                        object: questProvider,
                        notificationCenter: notificationCenter)

        questProvider.deactivateQuest(quest)

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testDeactivateQuest_whenQuestWasNotActiveBefore_shouldNotPostNotification() {
        let quest = Quest.makeQuest()
        setupQuestProvider(quests: [quest])

        let notificationExpectation = expectation(forNotification: .QuestManagerDidUpdateActiveQuests,
                                                  object: questProvider,
                                                  notificationCenter: notificationCenter)
        notificationExpectation.isInverted = true

        questProvider.deactivateQuest(quest)

        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
