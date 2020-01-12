//
//  Quest+MakeQuest.swift
//  GoMapTests
//
//  Created by Wolfgang Timme on 1/4/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

@testable import Go_Map__

extension Quest {
    /// Convenience method for creating a `Quest` for testing
    static func makeQuest(identifier: String = UUID().uuidString,
                          question: String = "Lorem ipsum?",
                          overpassWizardQuery: String = "dolor_sit:amet",
                          answers: [Answer] = [],
                          baseObjectMatcher: BaseObjectMatching? = nil) -> Quest {
        return Quest(identifier: identifier,
                     question: question,
                     overpassWizardQuery: overpassWizardQuery,
                     answers: answers,
                     baseObjectMatcher: baseObjectMatcher)
    }
}
