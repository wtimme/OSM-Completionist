//
//  MapViewController.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 2/28/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import UIKit
import SafariServices

extension MapViewController {
    @IBAction func openHelp() {
        let urlAsString = "https://wiki.openstreetmap.org/w/index.php?title=Go_Map!!&mobileaction=toggle_view_mobile"
        guard let url = URL(string: urlAsString) else { return }
        
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }
    
    /// Sets up "Peek and Pop", which allows the user to preview an object by performing the gesture.
    /// See: https://developer.apple.com/documentation/uikit/deprecated_symbols/implementing_peek_and_pop
    @objc func setupPeekAndPop() {
        guard #available(iOS 11.4, *) else {
            /// Peek and Pop requires at least iOS 11.4.
            return
        }
        
        registerForPreviewing(with: self, sourceView: mapView)
    }
}

extension MapViewController: UIViewControllerPreviewingDelegate {
    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let tappedNode = mapView.editorLayer.osmHitTest(location, radius: 10, testNodes: false, ignoreList: [], segment: nil) else {
            /// Only display a preview for nodes.
            return nil
        }
        
        guard
            let viewController = storyboard?.instantiateViewController(withIdentifier: "poiTabBar"),
            let poiTabBarController = viewController as? POITabBarController
        else {
            assertionFailure("Unable to instantiate the `poiTabBar` view controller")
            return nil
        }
        
        return poiTabBarController
    }
    
    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        present(viewControllerToCommit, animated: true)
    }
    
    
}
