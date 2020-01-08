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
    /// A unique string that identifies this `Quest`.
    /// This is used to refer to it when saving its `isActive` state.
    let identifier: String
    
    /// The question that the user is asked when encountering a map item for this quest.
    let question: String
    
    /// A query that is used to filter items that match this quest.
    ///
    /// Uses the [Overpass Turbo Wizard](https://wiki.openstreetmap.org/wiki/Overpass_turbo/Wizard) format.
    let overpassWizardQuery: String
}
