//
//  QuestProviderMock.swift
//  GoMapTests
//
//  Created by Wolfgang Timme on 1/4/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import Foundation
@testable import Go_Map__

class QuestProviderMock: QuestProviding {
    var quests = [Quest]()
    var activeQuests = [Quest]()

    private(set) var isQuestActiveCalled = false
    private(set) var isQuestActiveQuest: Quest?
    var isQuestActiveMockedReturnValue = false
    func isQuestActive(_ quest: Quest) -> Bool {
        isQuestActiveCalled = true
        isQuestActiveQuest = quest

        return isQuestActiveMockedReturnValue
    }

    var activateQuestCalled = false
    var activateQuestQuest: Quest?
    func activateQuest(_ quest: Quest) {
        activateQuestCalled = true
        activateQuestQuest = quest
    }

    var deactivateQuestCalled = false
    var deactivateQuestQuest: Quest?
    func deactivateQuest(_ quest: Quest) {
        deactivateQuestCalled = true
        deactivateQuestQuest = quest
    }
}
