//
//  EditorMapLayer.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 5/10/19.
//  Copyright © 2019 Bryce. All rights reserved.
//

@objc extension EditorMapLayer {
    
    func observeQuestChanges() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didReceiveActiveQuestsChangedNotification(_:)),
                                               name: .QuestManagerDidUpdateActiveQuests,
                                               object: nil)
    }
    
    func didReceiveActiveQuestsChangedNotification(_ note: Notification) {
        resetDisplayLayers()
    }
    
}
