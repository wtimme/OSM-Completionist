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
    
    // MARK: Private properties
    
    private let questManager: QuestManaging
    private let questProvider: QuestProviding
    private let queryParser: OverpassQueryParsing
    private let notificationCenter: NotificationCenter
    
    private var lastParsedQuery: String?
    private var lastMatcher: BaseObjectMatching?
    
    /// The `BaseObjectMatching` to match objects against quests that were provided by the `questProvider`.
    private var questMatchers = [BaseObjectMatching]()
    
    // MARK: Initializer
    
    init(questManager: QuestManaging,
         questProvider: QuestProviding,
         queryParser: OverpassQueryParsing,
         notificationCenter: NotificationCenter = .default) {
        self.questManager = questManager
        self.questProvider = questProvider
        self.queryParser = queryParser
        self.notificationCenter = notificationCenter
        
        super.init()
        
        notificationCenter.addObserver(self,
                                       selector: #selector(reloadMatchers),
                                       name: .QuestManagerDidUpdateActiveQuests,
                                       object: nil)
        
        reloadMatchers()
    }
    
    convenience override init() {
        let questManager = QuestManager()
        let questProvider = StaticQuestProvider()
        
        let parser = OverpassQueryParser()
        assert(parser != nil, "Unable to create the query parser.")
        
        self.init(questManager: questManager, questProvider: questProvider, queryParser: parser!)
    }
    
    // MARK: MapViewQuestAnnotationManaging
    
    func shouldShowQuestAnnotation(for baseObject: OsmBaseObject) -> Bool {
        for matcher in questMatchers {
            if matcher.matches(baseObject) {
                return true
            }
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
    
    // MARK: Private methods
    
    /// Reloads the matchers that are used to determine whether to display annotations.
    @objc private func reloadMatchers() {
        questMatchers = questProvider.activeQuests.compactMap { [weak self] quest in
            guard let self = self else { return nil }
            
            let parserResult = self.queryParser.parse(quest.overpassWizardQuery)
            switch parserResult {
            case let .success(matcher):
                return matcher
            case .error(_):
                return nil
            }
        }
    }

}
