//
//  MapViewModel.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 1/11/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import Foundation

@objc protocol MapViewModelDelegate: class {
    /// Asks the delegate to ask a multiple choice question.
    /// The delegate should allow the user to choose from one of the `choices`.
    /// Once the user made their choice, the delegate should execute the given `selectionHandler`, letting the view model take over again.
    ///
    /// - Parameters:
    ///   - question: The question to ask.
    ///   - choices: A list of answers to present.
    ///   - selectionHandler: Closure to execute when the user made their choice.
    func askMultipleChoiceQuestion(question: String,
                                   choices: [String],
                                   selectionHandler: @escaping (Int) -> Void)
    
    /// Asks the delegate to ask a question for which the user should enter a numerical value.
    /// The delegate does not need to validate whether the `String` that the user put in is a valid number; this will be done by the view model.
    /// Once the user has entered something, the delegate should execute the given `handler`, letting the view model take over again.
    /// 
    /// - Parameters:
    ///   - question: The question to ask.
    ///   - key: The key of the tag that will be updated with the number. Can be used as a placeholder.
    ///   - handler: Closure to execute when the user has entered a `String`.
    func askNumericQuestion(question: String,
                            key: Quest.Key,
                            handler: @escaping (String?) -> Void)
    
    /// Asks the delegate to finish the quest for the object that is currently selected by applying a tag.
    /// - Parameters:
    ///   - key: The key of the tag.
    ///   - value: The value of the tag.
    func finishQuestForSelectedObjectByApplyingTag(key: String, value: String)
}

class MapViewModel: NSObject {
    // MARK: Public properties
    
    @objc weak var delegate: MapViewModelDelegate?
    
    // MARK: Private properties
    
    private let activeQuestBaseObjectMatcher: ActiveQuestBaseObjectMatching
    
    // MARK: Initializer
    
    init(activeQuestBaseObjectMatcher: ActiveQuestBaseObjectMatching) {
        self.activeQuestBaseObjectMatcher = activeQuestBaseObjectMatcher
    }
    
    override convenience init() {
        let staticQuestProvider = StaticQuestProvider()
        let activeQuestBaseObjectMatcher = ActiveQuestsBaseObjectMatcher(questProvider: staticQuestProvider)
        
        self.init(activeQuestBaseObjectMatcher: activeQuestBaseObjectMatcher)
    }
    
    // MARK: Public methods
    
    @objc func presentQuestInterface(for baseObject: OsmBaseObject) {
        let quests = activeQuestBaseObjectMatcher.quests(matching: baseObject)
        
        guard let firstQuest = quests.first else {
            /// We cannot display a quest interface if there were no quests for the given object.
            return
        }
        
        switch firstQuest.solution {
        case .multipleChoice(_):
            presentMultipleChoiceQuestInterface(firstQuest)
        case .numeric(_):
            /// At the moment, the app only supports multiple choice quests.
            print("Numeric quest are not supported at the moment.")
        }
    }
    
    // MARK: Private methods
    
    private func presentMultipleChoiceQuestInterface(_ quest: Quest) {
        guard case let .multipleChoice(answers) = quest.solution else { return }
        
        let choices: [String] = answers.map { answer in
            "\(answer.title) (\(answer.key)=\(answer.value))"
        }
        
        delegate?.askMultipleChoiceQuestion(question: quest.question,
                                            choices: choices,
                                            selectionHandler: { [weak self] indexOfSelectedAnswer in
                                                guard answers.indices.contains(indexOfSelectedAnswer) else {
                                                    /// The index is out of range; ignore.
                                                    return
                                                }
                                                
                                                let selectedAnswer = answers[indexOfSelectedAnswer]
                                                
                                                self?.delegate?.finishQuestForSelectedObjectByApplyingTag(key: selectedAnswer.key,
                                                                                                          value: selectedAnswer.value)
        })
    }
}
