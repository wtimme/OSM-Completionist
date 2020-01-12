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
    /// The key of a tag.
    typealias Key = String
    
    /// Ways that the question can be answered.
    enum Solution {
        /// The user can choose from a list of pre-defined answers.
        case multipleChoice([Answer])
        
        /// The user can enter a number.
        /// The associated `Key` value is the key of the tag that the number will be assigned to.
        case numeric(Key)
    }
    
    /// An answer that the user can choose.
    struct Answer {
        /// Title of the answer. Should be human-readable and easy to understand.
        let title: String
        
        /// The key to update when the user selects this answer.
        let key: Key
        
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
    
    /// The way that this quest can be resolved.
    let solution: Solution
    
    /// An object that allows for the quest to be matched against `OsmBaseObject` instances.
    let baseObjectMatcher: BaseObjectMatching?
    
    init(identifier: String,
         question: String,
         overpassWizardQuery: String,
         solution: Solution,
         baseObjectMatcher: BaseObjectMatching?) {
        self.identifier = identifier
        self.question = question
        self.overpassWizardQuery = overpassWizardQuery
        self.solution = solution
        self.baseObjectMatcher = baseObjectMatcher
    }
    
    init(identifier: String,
         question: String,
         overpassWizardQuery: String,
         solution: Solution,
         queryParser: OverpassQueryParsing? = OverpassQueryParser()) {
        self.identifier = identifier
        self.question = question
        self.overpassWizardQuery = overpassWizardQuery
        self.solution = solution
        
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
