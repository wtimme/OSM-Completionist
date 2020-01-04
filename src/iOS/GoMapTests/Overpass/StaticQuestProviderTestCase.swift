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

}
