//
//  MapViewViewModelTestCase.swift
//  GoMapTests
//
//  Created by Wolfgang Timme on 1/11/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import XCTest
@testable import Go_Map__

class MapViewViewModelTestCase: XCTestCase {
    
    var viewModel: MapViewViewModel!
    var activeQuestBaseObjectMatcherMock: ActiveQuestBaseObjectMatcherMock!
    
    override func setUp() {
        super.setUp()
        
        activeQuestBaseObjectMatcherMock = ActiveQuestBaseObjectMatcherMock()
        viewModel = MapViewViewModel(activeQuestBaseObjectMatcher: activeQuestBaseObjectMatcherMock)
    }

    override func tearDown() {
        viewModel = nil
        activeQuestBaseObjectMatcherMock = nil
        
        super.tearDown()
    }

}
