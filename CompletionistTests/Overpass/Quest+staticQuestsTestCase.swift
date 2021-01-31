//
//  Quest+staticQuestsTestCase.swift
//  GoMapTests
//
//  Created by Wolfgang Timme on 1/11/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

@testable import Go_Map__
import XCTest

class Quest_staticQuestsTestCase: XCTestCase {
    func testAllStaticQuests_shouldHaveBaseObjectMatcher() {
        let allStaticQuests = [Quest.makeAccessibleToiletsQuest(),
                               Quest.makeParkingFeeQuest(),
                               Quest.makeBenchBackrestQuest(),
                               Quest.makePlaygroundAccessQuest(),
                               Quest.makeToiletQuest(),
                               Quest.makeBicycleParkingQuest(),
                               Quest.makeMotorcycleParkingQuest()]

        allStaticQuests.forEach { quest in
            XCTAssertNotNil(quest.baseObjectMatcher)
        }
    }
}
