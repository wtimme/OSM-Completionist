//
//  QuestProviding.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 1/4/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

/// Protocol for an object that provides `Quest` instances
protocol QuestProviding {
    var quests: [Quest] { get }
}
