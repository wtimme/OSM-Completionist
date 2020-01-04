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

    override func setUp() {
        super.setUp()
        
        questProvider = StaticQuestProvider()
    }

    override func tearDown() {
        questProvider = nil
        
        super.tearDown()
    }

}
