//
//  MapViewModel.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 1/11/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import Foundation

@objc protocol MapViewModelDelegate: class {
    func askMultipleChoiceQuestion(question: String)
}

class MapViewModel: NSObject {
    // MARK: Public properties
    
    @objc weak var delegate: MapViewModelDelegate?
    
    // MARK: Private properties
    
    private let activeQuestBaseObjectMatcher: ActiveQuestBaseObjectMatching
    
    // MARK: Initializer
    
    init(activeQuestBaseObjectMatcher: ActiveQuestBaseObjectMatching) {
        self.activeQuestBaseObjectMatcher = activeQuestBaseObjectMatcher
    }
    
    override convenience init() {
        let staticQuestProvider = StaticQuestProvider()
        let activeQuestBaseObjectMatcher = ActiveQuestsBaseObjectMatcher(questProvider: staticQuestProvider)
        
        self.init(activeQuestBaseObjectMatcher: activeQuestBaseObjectMatcher)
    }
    
    // MARK: Public methods
    
    @objc func presentQuestInterface(for baseObject: OsmBaseObject) -> Bool {
        let quests = activeQuestBaseObjectMatcher.quests(matching: baseObject)
        
        guard let firstQuest = quests.first else {
            /// We cannot display a quest interface if there were no quests for the given object.
            return false
        }
        
        delegate?.askMultipleChoiceQuestion(question: firstQuest.question)
        
        return true
    }
}
