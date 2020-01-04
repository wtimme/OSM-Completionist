//
//  QuestListViewModel.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 1/4/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

class QuestListViewModel {
    // MARK: Types
    
    /// An item in the list.
    struct Item {
        let title: String
        let subtitle: String
    }
    
    // MARK: Private properties
    
    /// An object that provides the `Quest` instances that are displayed in the list
    private let questProvider: QuestProviding
    
    // MARK: Initializer
    
    init(questProvider: QuestProviding = StaticQuestProvider()) {
        self.questProvider = questProvider
    }
    
    // MARK: Public methods
    
    /// The number of items visible in the list
    func numberOfItems() -> Int {
        return questProvider.quests.count
    }
}
