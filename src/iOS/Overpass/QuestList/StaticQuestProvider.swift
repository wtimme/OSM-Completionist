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
    
    /// Key for when storing the identifiers of the active quests in the `UserDefaults`.
    private let activeQuestIdentifierUserDefaultsKey: String
    
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
    
    init(userDefaults: UserDefaults = .standard,
         activeQuestIdentifierUserDefaultsKey: String = "active_quest_identifiers") {
        self.userDefaults = userDefaults
        self.activeQuestIdentifierUserDefaultsKey = activeQuestIdentifierUserDefaultsKey
    }
}

extension StaticQuestProvider: QuestProviding {
    var quests: [Quest] {
        [accessibleToiletsQuest,
         parkingFeeQuest]
    }
    
    func isQuestActive(_ quest: Quest) -> Bool {
        return activeQuestIdentifiersFromUserDefaults().contains(quest.identifier)
    }
    
    func activateQuest(_ quest: Quest) {
        var identifiers = activeQuestIdentifiersFromUserDefaults()
        
        guard !identifiers.contains(quest.identifier) else {
            /// The quest is already active; ignore the call.
            return
        }
        
        identifiers.append(quest.identifier)
        
        userDefaults.set(identifiers, forKey: activeQuestIdentifierUserDefaultsKey)
    }
    
    private func activeQuestIdentifiersFromUserDefaults() -> [String] {
        guard
            let activeQuestIdentifiers = userDefaults.object(forKey: activeQuestIdentifierUserDefaultsKey) as? [String]
        else {
            return []
        }
        
        return activeQuestIdentifiers
    }
}
