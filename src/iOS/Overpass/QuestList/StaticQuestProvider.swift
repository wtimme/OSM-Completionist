//
//  StaticQuestProvider.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 1/4/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

/// Provides static `Quest`s that are compiled into the app.
class StaticQuestProvider {
    // MARK: Private properties
    
    /// The `UserDefaults` instances for persisting the active quests.
    private let userDefaults: UserDefaults
    
    private var accessibleToiletsQuest: Quest {
        let identifier = "accessible_toilets"
        let question = "Are these toilets wheelchair accessible?"
        let query = "(type:node or type:way) and amenity=toilets and access !~ \"private|customers\" and wheelchair!=*"
        
        return Quest(identifier: identifier,
                     question: question,
                     overpassWizardQuery: query)
    }
    
    private var parkingFeeQuest: Quest {
        let identifier = "parking_fee"
        let question = "Does it cost a fee to park here? "
        let query = "(type:node or type:way) and amenity=parking and fee!=* and access~\"yes|customers|public\""
        
        return Quest(identifier: identifier,
                     question: question,
                     overpassWizardQuery: query)
    }
    
    // MARK: Initializer
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
}

extension StaticQuestProvider: QuestProviding {
    var quests: [Quest] {
        [accessibleToiletsQuest,
         parkingFeeQuest]
    }
    
    func isQuestActive(_ quest: Quest) -> Bool {
        return false
    }
}
