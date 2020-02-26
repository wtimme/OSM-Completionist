//
//  FeedbackGenerator.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 2/26/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import Foundation

@objc enum FeedbackType: Int {
    case error, success
}

@objc protocol FeedbackGenerating {
    func generateFeedback(type: FeedbackType)
}

@objcMembers class FeedbackGenerator: NSObject {
    static let shared: FeedbackGenerating = FeedbackGenerator()
}

extension FeedbackGenerator: FeedbackGenerating {
    func generateFeedback(type: FeedbackType) {
        guard #available(iOS 10.0, *) else {
            /// `UIFeedbackGenerator` is only available for iOS 10 and later.
            return
        }
        
        let generator = UINotificationFeedbackGenerator()
        
        let notificationType: UINotificationFeedbackGenerator.FeedbackType
        switch type {
        case .error:
            notificationType = .error
        case .success:
            notificationType = .success
        }
        
        generator.notificationOccurred(notificationType)
    }
}
