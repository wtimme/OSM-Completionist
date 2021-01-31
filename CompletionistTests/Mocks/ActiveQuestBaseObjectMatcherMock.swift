//
//  ActiveQuestBaseObjectMatcherMock.swift
//  GoMapTests
//
//  Created by Wolfgang Timme on 1/11/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import Foundation
@testable import Go_Map__

class ActiveQuestBaseObjectMatcherMock: ActiveQuestBaseObjectMatching {
    private(set) var baseObject: OsmBaseObject?
    var questsToReturn = [Quest]()
    func quests(matching baseObject: OsmBaseObject) -> [Quest] {
        self.baseObject = baseObject

        return questsToReturn
    }
}
