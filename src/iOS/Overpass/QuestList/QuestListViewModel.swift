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
        enum Accessory {
            case none, checkmark
        }
        
        let title: String
        let subtitle: String
        let accessory: Accessory
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
    
    /// Determines the `Item` to display at the given `index`.
    /// - Parameter index: The index of the item.
    func item(at index: Int) -> Item? {
        let allQuests = questProvider.quests
        
        guard allQuests.indices.contains(index) else {
            /// The index is out-of-range.
            return nil
        }
        
        let quest = allQuests[index]
        
        let accessory: Item.Accessory = questProvider.isQuestActive(quest) ? .checkmark : .none
        
        return Item(title: quest.question,
                    subtitle: quest.overpassWizardQuery,
                    accessory: accessory)
    }
}
