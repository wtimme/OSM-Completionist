//
//  Quest.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 1/4/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

/// Represents a task/challenge that the user should fulfil.
///
/// The name stems from the Android app [StreetComplete](https://wiki.openstreetmap.org/wiki/StreetComplete/Quests).
struct Quest {
    /// An answer that the user can choose.
    struct Answer {
        /// Title of the answer. Should be human-readable and easy to understand.
        let title: String
        
        /// The key to update when the user selects this answer.
        let key: String
        
        /// The value to set the `key` to when the user selects this answer.
        let value: String
    }
    
    /// A unique string that identifies this `Quest`.
    /// This is used to refer to it when saving its `isActive` state.
    let identifier: String
    
    /// The question that the user is asked when encountering a map item for this quest.
    let question: String
    
    /// A query that is used to filter items that match this quest.
    ///
    /// Uses the [Overpass Turbo Wizard](https://wiki.openstreetmap.org/wiki/Overpass_turbo/Wizard) format.
    let overpassWizardQuery: String
    
    /// A list of answers between the user can choose when encountering items of this quest.
    let answers: [Answer]
    
    /// An object that allows
    let baseObjectMatcher: BaseObjectMatching?
    
    init(identifier: String,
         question: String,
         overpassWizardQuery: String,
         answers: [Answer],
         queryParser: OverpassQueryParsing? = OverpassQueryParser()) {
        self.identifier = identifier
        self.question = question
        self.overpassWizardQuery = overpassWizardQuery
        self.answers = answers
        
        switch queryParser?.parse(overpassWizardQuery) {
        case .error(_):
            self.baseObjectMatcher = nil
        case let .success(baseObjectMatcher):
            self.baseObjectMatcher = baseObjectMatcher
        case nil:
            self.baseObjectMatcher = nil            
        }
    }
}
