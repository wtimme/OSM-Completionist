//
//  ContactUsViewController.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 4/16/19.
//  Copyright © 2019 Bryce. All rights reserved.
//

import Foundation
import SafariServices

extension ContactUsViewController {
    
    @objc func openTestFlightURL() {
        guard let url = URL(string: "https://testflight.apple.com/join/v1tyM5yU") else { return }
        
        UIApplication.shared.openURL(url)
    }
    
    @objc func presentGitHubIssuesPage() {
        guard let url = URL(string: "https://github.com/wtimme/OSM-Completionist/issues") else { return }
        
        let viewController = SFSafariViewController(url: url)
        present(viewController, animated: true)
    }
    
}
