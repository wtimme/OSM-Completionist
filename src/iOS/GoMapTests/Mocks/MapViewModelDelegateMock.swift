//
//  MapViewModelDelegateMock.swift
//  GoMapTests
//
//  Created by Wolfgang Timme on 1/12/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import Foundation
@testable import Go_Map__

class MapViewModelDelegateMock {
    private(set) var question: String?
    private(set) var choices = [String]()
    private(set) var selectionHandler: ((Int) -> Void)?
    
    private(set) var didCallFinishQuest = false
    private(set) var didFinishQuestTag: (String, String)?
}

extension MapViewModelDelegateMock: MapViewModelDelegate {
    func askMultipleChoiceQuestion(question: String, choices: [String], selectionHandler: @escaping (Int) -> Void) {
        self.question = question
        self.choices = choices
        self.selectionHandler = selectionHandler
    }
    
    func finishQuestForSelectedObjectByApplyingTag(key: String, value: String) {
        didCallFinishQuest = true
        
        didFinishQuestTag = (key, value)
    }
}
