//
//  QuestListViewModelTestCase.swift
//  GoMapTests
//
//  Created by Wolfgang Timme on 1/4/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import XCTest

@testable import Go_Map__

class QuestListViewModelTestCase: XCTestCase {
    
    var viewModel: QuestListViewModel!
    var questProviderMock: QuestProviderMock!

    override func setUp() {
        super.setUp()
        
        questProviderMock = QuestProviderMock()
        viewModel = QuestListViewModel(questProvider: questProviderMock)
    }

    override func tearDown() {
        viewModel = nil
        questProviderMock = nil
        
        super.tearDown()
    }

}
