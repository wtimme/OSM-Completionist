//
//  QuestListViewModelDelegateMock.swift
//  GoMapTests
//
//  Created by Wolfgang Timme on 1/4/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import Foundation
@testable import Go_Map__

class QuestListViewModelDelegateMock: QuestListViewModelDelegate {
    private(set) var reloadItemCalled = false
    private(set) var reloadItemIndex: Int?

    func reloadItem(at index: Int) {
        reloadItemCalled = true
        reloadItemIndex = index
    }
}
