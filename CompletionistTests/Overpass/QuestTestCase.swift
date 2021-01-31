//
//  QuestTestCase.swift
//  GoMapTests
//
//  Created by Wolfgang Timme on 1/11/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

@testable import Go_Map__
import XCTest

class QuestTestCase: XCTestCase {
    func testInitWithQueryParser_whenQueryParserIsNil_shouldResultInBaseObjectMatcherNil() {
        /// Given
        let queryParser: OverpassQueryParsing? = nil

        /// When
        let quest = Quest(identifier: "",
                          question: "",
                          overpassWizardQuery: "",
                          solution: .multipleChoice([]),
                          queryParser: queryParser)

        /// Then
        XCTAssertNil(quest.baseObjectMatcher)
    }

    func testInitWithQueryParser_whenQueryParserEncountersAnError_shouldResultInBaseObjectMatcherNil() {
        /// Given
        let queryParserMock = OverpassQueryParserMock()
        queryParserMock.mockedResult = .error("")

        /// When
        let quest = Quest(identifier: "",
                          question: "",
                          overpassWizardQuery: "",
                          solution: .multipleChoice([]),
                          queryParser: queryParserMock)

        /// Then
        XCTAssertNil(quest.baseObjectMatcher)
    }

    func testInitWithQueryParser_whenQueryParserSucceedsWithNil_shouldResultInBaseObjectMatcherNil() {
        /// Given
        let queryParserMock = OverpassQueryParserMock()
        queryParserMock.mockedResult = .success(nil)

        /// When
        let quest = Quest(identifier: "",
                          question: "",
                          overpassWizardQuery: "",
                          solution: .multipleChoice([]),
                          queryParser: queryParserMock)

        /// Then
        XCTAssertNil(quest.baseObjectMatcher)
    }

    func testInitWithQueryParser_whenQueryParserSucceedsWithMatcher_shouldResultInParsedBaseObjectMatcher() {
        /// Given
        let queryParserMock = OverpassQueryParserMock()
        let baseObjectMatcherMock = BaseObjectMatcherMock()
        queryParserMock.mockedResult = .success(baseObjectMatcherMock)

        /// When
        let quest = Quest(identifier: "",
                          question: "",
                          overpassWizardQuery: "",
                          solution: .multipleChoice([]),
                          queryParser: queryParserMock)

        /// Then

        /// The Quest's `baseObjectMatcher` should be a mock.
        XCTAssertEqual((quest.baseObjectMatcher as? BaseObjectMatcherMock).require().identifier,
                       baseObjectMatcherMock.identifier)
    }
}
