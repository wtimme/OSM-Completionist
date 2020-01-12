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
}

extension MapViewModelDelegateMock: MapViewModelDelegate {
    func askMultipleChoiceQuestion(question: String) {
        self.question = question
    }
}
