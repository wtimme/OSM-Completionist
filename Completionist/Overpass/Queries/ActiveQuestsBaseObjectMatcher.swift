//
//  ActiveQuestsBaseObjectMatcher.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 1/11/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import Foundation

/// An object that matches a base object against the list of active quests.
protocol ActiveQuestBaseObjectMatching {
    /// Determines the quests that match the given `baseObject`.
    /// - Parameter baseObject: The base object to match.
    func quests(matching baseObject: OsmBaseObject) -> [Quest]
}

class ActiveQuestsBaseObjectMatcher {
    // MARK: Private properties

    private let questProvider: QuestProviding

    // MARK: Initalizer

    init(questProvider: QuestProviding) {
        self.questProvider = questProvider
    }
}

extension ActiveQuestsBaseObjectMatcher: ActiveQuestBaseObjectMatching {
    func quests(matching baseObject: OsmBaseObject) -> [Quest] {
        return questProvider.activeQuests.filter { quest in
            quest.baseObjectMatcher?.matches(baseObject) ?? false
        }
    }
}
