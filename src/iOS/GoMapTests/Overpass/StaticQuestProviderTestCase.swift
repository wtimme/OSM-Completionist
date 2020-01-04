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

    override func setUp() {
        super.setUp()
        
        UserDefaults().removePersistentDomain(forName: userDefaultsSuiteName)
        userDefaults = UserDefaults(suiteName: userDefaultsSuiteName)
        
        questProvider = StaticQuestProvider(userDefaults: userDefaults,
                                            activeQuestIdentifierUserDefaultsKey: activeQuestIdentifierUserDefaultsKey)
    }

    override func tearDown() {
        questProvider = nil
        userDefaults = nil
        
        super.tearDown()
    }
    
    // MARK: isQuestActive(_:)
    
    func testIsQuestActive_shouldInitiallyReturnFalseForAllQuests() {
        questProvider.quests.forEach { quest in
            XCTAssertFalse(questProvider.isQuestActive(quest))
        }
    }
    
    func testIsQuestActive_whenTheQuestIdentifierIsPartOfTheUserDefaults_shouldReturnTrue() {
        /// Just use the first quest as an example.
        guard let firstQuest = questProvider.quests.first else {
            XCTFail()
            return
        }
        
        /// Store the identifier in the `UserDefaults`.
        userDefaults.set([firstQuest.identifier], forKey: activeQuestIdentifierUserDefaultsKey)
        
        XCTAssertTrue(questProvider.isQuestActive(firstQuest))
    }
    
    /// This method makes sure that the values are persisted in the `UserDefaults`, and that when a second `StaticQuestProvider` is initialized
    /// with the same `UserDefaults` and the same `activeQuestIdentifierUserDefaultsKey`, a `Quest` is still considered "active".
    func testIsQuestActive_whenUsingTheSameUserDefaultsAndTheSameUserDefaultsKey_shouldStillReturnTrue() {
        /// Just use the first quest as an example.
        guard let firstQuest = questProvider.quests.first else {
            XCTFail()
            return
        }
        
        /// Store the identifier in the `UserDefaults`.
        userDefaults.set([firstQuest.identifier], forKey: activeQuestIdentifierUserDefaultsKey)
        
        /// Create a second `StaticQuestProvider` with the same values.
        let secondQuestProvider = StaticQuestProvider(userDefaults: userDefaults,
                                                      activeQuestIdentifierUserDefaultsKey: activeQuestIdentifierUserDefaultsKey)
        XCTAssertTrue(secondQuestProvider.isQuestActive(firstQuest))
    }
    
    // MARK: activateQuest(_:)
    
    func testActiveQuest_shouldStoreQuestIdentifierInUserDefaults() {
        /// Just use the first quest as an example.
        guard let firstQuest = questProvider.quests.first else {
            XCTFail()
            return
        }
        
        questProvider.activateQuest(firstQuest)
        
        guard
            let activeQuestIdentifiers = userDefaults.object(forKey: activeQuestIdentifierUserDefaultsKey) as? [String]
        else {
            XCTFail()
            return
        }
        
        XCTAssertTrue(activeQuestIdentifiers.contains(firstQuest.identifier))
    }
    
    func testActiveQuest_shouldStoreQuestIdentifierInUserDefaultsOnlyOnce() {
        /// Just use the first quest as an example.
        guard let firstQuest = questProvider.quests.first else {
            XCTFail()
            return
        }
        
        for _ in 1...10 {
            questProvider.activateQuest(firstQuest)
        }
        
        guard
            let activeQuestIdentifiers = userDefaults.object(forKey: activeQuestIdentifierUserDefaultsKey) as? [String]
        else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(activeQuestIdentifiers.filter({ $0 == firstQuest.identifier }).count, 1)
    }
    
    // MARK: deactivateQuest(_:)
    
    func testDeactiveQuest_shouldRemoveTheQuestIdentifierFromUserDefaults() {
        /// Just use the first quest as an example.
        guard let firstQuest = questProvider.quests.first else {
            XCTFail()
            return
        }
        
        userDefaults.set([firstQuest.identifier], forKey: activeQuestIdentifierUserDefaultsKey)
        
        questProvider.deactivateQuest(firstQuest)
        
        guard
            let activeQuestIdentifiers = userDefaults.object(forKey: activeQuestIdentifierUserDefaultsKey) as? [String]
        else {
            XCTFail()
            return
        }
        
        XCTAssertFalse(activeQuestIdentifiers.contains(firstQuest.identifier))
    }

}
