//
//  MapViewQuestAnnotationManager.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 5/10/19.
//  Copyright © 2019 Bryce. All rights reserved.
//

import Foundation

@objc protocol MapViewQuestAnnotationManaging {
    func shouldShowQuestAnnotation(for baseObject: OsmBaseObject) -> Bool
}

@objc class MapViewQuestAnnotationManager: NSObject, MapViewQuestAnnotationManaging {
    
    // MARK: Public properties
    
    @objc static let shared = MapViewQuestAnnotationManager()
    
    // MARK: Private properties
    
    private let questManager: QuestManaging
    private let queryParser: OverpassQueryParsing
    private let activeQuestsBaseObjectMatcher: ActiveQuestBaseObjectMatching
    
    private var lastParsedQuery: String?
    private var lastMatcher: BaseObjectMatching?
    
    // MARK: Initializer
    
    init(questManager: QuestManaging,
         queryParser: OverpassQueryParsing,
         activeQuestsBaseObjectMatcher: ActiveQuestBaseObjectMatching) {
        self.questManager = questManager
        self.queryParser = queryParser
        self.activeQuestsBaseObjectMatcher = activeQuestsBaseObjectMatcher
    }
    
    convenience override init() {
        let questManager = QuestManager()
        let questProvider = StaticQuestProvider()
        let activeQuestsBaseObjectMatcher = ActiveQuestsBaseObjectMatcher(questProvider: questProvider)
        
        let parser = OverpassQueryParser()
        assert(parser != nil, "Unable to create the query parser.")
        
        self.init(questManager: questManager,
                  queryParser: parser!,
                  activeQuestsBaseObjectMatcher: activeQuestsBaseObjectMatcher)
    }
    
    // MARK: MapViewQuestAnnotationManaging
    
    func shouldShowQuestAnnotation(for baseObject: OsmBaseObject) -> Bool {
        if !activeQuestsBaseObjectMatcher.quests(matching: baseObject).isEmpty {
            return true
        }
        
        guard let overpassTurboWizardQueryMatcher = matcherFromOverpassTurboWizardQuery() else {
            /// Without a matcher, there's no need to show a quest annotation.
            return false
        }
        
        return overpassTurboWizardQueryMatcher.matches(baseObject)
    }
    
    /// Uses the Overpass Turbo Wizard Query that the user entered and attempts to create a matcher from it.
    private func matcherFromOverpassTurboWizardQuery() -> BaseObjectMatching? {
        guard let activeQuery = questManager.activeQuestQuery else {
            /// Without an active query, there's no matcher.
            return nil
        }
        
        guard activeQuery != lastParsedQuery else {
            // We've already parsed this query before, and there's no need to do it again.
            /// Use the existing matcher.
            return lastMatcher
        }
        
        // Remember the query that was parsed last.
        lastParsedQuery = activeQuery
        
        guard
            case let .success(parsedMatcher) = queryParser.parse(activeQuery),
            let matcher = parsedMatcher
        else {
            lastMatcher = nil
            
            return nil
        }
        
        // Remember the parsed matcher.
        lastMatcher = matcher
        
        return matcher
    }

}
