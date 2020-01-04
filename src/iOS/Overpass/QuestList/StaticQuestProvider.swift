//
//  StaticQuestProvider.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 1/4/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

/// Provides static `Quest`s that are compiled into the app.
class StaticQuestProvider {
    private var accessibleToiletsQuest: Quest {
        let question = "Are these toilets wheelchair accessible?"
        let query = "(type:node or type:way) and amenity=toilets and access !~ \"private|customers\" and wheelchair!=*"
        
        return Quest(question: question,
                     overpassWizardQuery: query)
    }
}

extension StaticQuestProvider: QuestProviding {
    var quests: [Quest] {
        [accessibleToiletsQuest]
    }
}
