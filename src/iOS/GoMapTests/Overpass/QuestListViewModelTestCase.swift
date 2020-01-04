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

    override func setUp() {
        super.setUp()
        
        viewModel = QuestListViewModel()
    }

    override func tearDown() {
        viewModel = nil
        
        super.tearDown()
    }

}
