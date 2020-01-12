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
}

extension MapViewModelDelegateMock: MapViewModelDelegate {
    func askMultipleChoiceQuestion(question: String, choices: [String]) {
        self.question = question
        self.choices = choices
    }
}
