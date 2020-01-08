//
//  MapViewQuestAnnotationManagerTestCase.swift
//  GoMapTests
//
//  Created by Wolfgang Timme on 5/10/19.
//  Copyright © 2019 Bryce. All rights reserved.
//

import XCTest

@testable import Go_Map__

class MapViewQuestAnnotationManagerTestCase: XCTestCase {
    
    var manager: MapViewQuestAnnotationManaging!
    var questManagerMock: QuestManagerMock!
    var questProviderMock: QuestProviderMock!
    var queryParserMock: OverpassQueryParserMock!
    var notificationCenter: NotificationCenter!

    override func setUp() {
        super.setUp()
        
        questManagerMock = QuestManagerMock()
        questProviderMock = QuestProviderMock()
        queryParserMock = OverpassQueryParserMock()
        notificationCenter = NotificationCenter()
        
        setupManager()
    }

    override func tearDown() {
        manager = nil
        questManagerMock = nil
        queryParserMock = nil
        notificationCenter = nil
        
        super.tearDown()
    }
    
    // MARK: Private methods
    
    private func setupManager() {
        manager = MapViewQuestAnnotationManager(questManager: questManagerMock,
                                                questProvider: questProviderMock,
                                                queryParser: queryParserMock,
                                                notificationCenter: notificationCenter)
    }
    
    // MARK: shouldShowQuestAnnotation(for:)
    
    func testShowAnnotationWithoutActiveQueryShouldNotAskParserToParse() {
        let query: String? = nil
        questManagerMock.activeQuestQuery = query
        let object = OsmBaseObject()
        
        _ = manager.shouldShowQuestAnnotation(for: object)
        
        XCTAssertEqual(queryParserMock.parseCallCounter, 0)
    }
    
    func testShowAnnotationWithActiveQueryShouldAskParserToParse() {
        let query: String? = "lorem ipsum dolor sit amet"
        questManagerMock.activeQuestQuery = query
        let object = OsmBaseObject()
        
        _ = manager.shouldShowQuestAnnotation(for: object)
        
        XCTAssertEqual(queryParserMock.parseCallCounter, 1)
        XCTAssertEqual(queryParserMock.queries.first, query)
    }
    
    func testShowAnnotationWithActiveQueryThatIsValidShouldOnlyAskParserToParseIfQueryWasChanged() {
        let object = OsmBaseObject()
        
        questManagerMock.activeQuestQuery = "man_made = surveillance"
        
        // For the first query, act as if the result did not match.
        let negativeMatcher = BaseObjectMatcherMock()
        negativeMatcher.doesMatch = false
        queryParserMock.mockedResult = .success(negativeMatcher)
        
        for _ in 0...10 {
            XCTAssertFalse(manager.shouldShowQuestAnnotation(for: object))
        }
        XCTAssertEqual(queryParserMock.parseCallCounter, 1)
        
        // Now change the query.
        questManagerMock.activeQuestQuery = "camera:mount = wall"
        
        // For the second query, act as if the result matched.
        let positiveMatcher = BaseObjectMatcherMock()
        positiveMatcher.doesMatch = true
        queryParserMock.mockedResult = .success(positiveMatcher)
        
        for _ in 0...10 {
            XCTAssertTrue(manager.shouldShowQuestAnnotation(for: object))
        }
        XCTAssertEqual(queryParserMock.parseCallCounter, 2)
    }
    
    func testShowAnnotationWithQueryThatCausesParserErrorShouldReturnFalse() {
        let query: String? = "lorem ipsum dolor sit amet"
        questManagerMock.activeQuestQuery = query
        queryParserMock.mockedResult = .error("An error occurred.")
        
        let object = OsmBaseObject()
        XCTAssertFalse(manager.shouldShowQuestAnnotation(for: object))
    }
    
    func testShowAnnotationWithQueryThatResultsInAnEmptyResultShouldReturnFalse() {
        let query: String? = "lorem"
        questManagerMock.activeQuestQuery = query
        queryParserMock.mockedResult = .success(nil)
        
        let object = OsmBaseObject()
        XCTAssertFalse(manager.shouldShowQuestAnnotation(for: object))
    }
    
    func testShowAnnotationWithValidQueryAskMatcherIfTheGivenObjectMatches() {
        let query: String? = "man_made = surveillance"
        questManagerMock.activeQuestQuery = query
        
        let matcher = BaseObjectMatcherMock()
        queryParserMock.mockedResult = .success(matcher)
        
        let object = OsmBaseObject()
        XCTAssertFalse(manager.shouldShowQuestAnnotation(for: object))
        
        XCTAssertEqual(matcher.object, object)
    }
    
    // MARK: Initial loading of quests
    
    func testManager_whenInitialized_shouldAskParserToParseQueriesOfActiveQuests() {
        /// Given
        let firstQuery = "man_made = surveillance"
        let secondQuery = "backrest is null"
        questProviderMock.activeQuests = [Quest.makeQuest(overpassWizardQuery: firstQuery),
                                           Quest.makeQuest(overpassWizardQuery: secondQuery)]

        /// When
        setupManager()

        /// Then
        XCTAssertEqual(queryParserMock.queries, [firstQuery, secondQuery],
                       "The annotation manager should've asked the parser to parse the queries")
    }
    
    func testManager_whenInitialized_shouldUseTheMatchersTheParserReturnedForTheActiveQuests() {
        /// Given
        questProviderMock.activeQuests = [Quest.makeQuest(overpassWizardQuery: "backrest is null")]
        questManagerMock.activeQuestQuery = "man_made = surveillance"
        
        let firstMatcher = BaseObjectMatcherMock()
        queryParserMock.mockedResult = .success(firstMatcher)
        
        let object = OsmBaseObject()
        
        /// During initialization, the manager will parse the quests provided by the `QuestProviding` object.
        setupManager()
        
        /// Create a second matcher that will be returned when the `MapViewQuestAnnotationManager` asks the parser
        /// to parse the `QuestManager`'s `activeQuestQuery`.
        /// We do this in order to make sure that the `MapViewQuestAnnotationManager` uses _both_ matchers.
        let secondMatcher = BaseObjectMatcherMock()
        queryParserMock.mockedResult = .success(secondMatcher)
        
        /// When
        _ = manager.shouldShowQuestAnnotation(for: object)
        
        /// Then
        XCTAssertEqual(firstMatcher.object, object,
                       "The annotation manager should've checked the object against the first matcher")
    }
    
    // MARK: QuestManagerDidUpdateActiveQuests notification
    
    func testManager_whenReceivingQuestManagerDidUpdateActiveQuestsNotification_shouldAskParserToParseQueriesOfActiveQuests() {
        /// Given
        let firstQuery = "man_made = surveillance"
        let secondQuery = "backrest is null"
        questProviderMock.activeQuests = [Quest.makeQuest(overpassWizardQuery: firstQuery),
                                          Quest.makeQuest(overpassWizardQuery: secondQuery)]
        
        /// When
        notificationCenter.post(name: .QuestManagerDidUpdateActiveQuests,
                                object: questProviderMock)
        
        /// Then
        XCTAssertEqual(queryParserMock.queries, [firstQuery, secondQuery],
                       "The annotation manager should've asked the parser to parse the queries")
    }
    
    func testManager_whenReceivingQuestManagerDidUpdateActiveQuestsNotification_shouldUseTheMatchersTheParserReturnedForTheActiveQuests() {
        /// Given
        let object = OsmBaseObject()
        
        /// During initialization, the manager will parse the quests provided by the `QuestProviding` object.
        setupManager()
        
        /// Create a matcher _after_ initialization.
        /// We do this in order to make sure that the `MapViewQuestAnnotationManager` uses that one after receiving the notification.
        let matcher = BaseObjectMatcherMock()
        queryParserMock.mockedResult = .success(matcher)
        
        questProviderMock.activeQuests = [Quest.makeQuest(overpassWizardQuery: "backrest is null")]
        notificationCenter.post(name: .QuestManagerDidUpdateActiveQuests,
                                object: questProviderMock)
        
        /// When
        _ = manager.shouldShowQuestAnnotation(for: object)
        
        /// Then
        XCTAssertEqual(matcher.object, object,
                       "The annotation manager should've checked the object against the matcher")
    }

}
