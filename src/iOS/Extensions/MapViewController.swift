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
    
    private func viewControllerForPreviewingNode(_ node: OsmNode) -> UIViewController? {
        guard
            let viewController = storyboard?.instantiateViewController(withIdentifier: "poiTabBar"),
            let poiTabBarController = viewController as? POITabBarController
        else {
            assertionFailure("Unable to instantiate the `poiTabBar` view controller")
            return nil
        }
        
        poiTabBarController.selection = node
        poiTabBarController.selectTagsViewController()
        
        poiTabBarController.tabBar.isHidden = true
        
        if let selectedNavigationController = poiTabBarController.selectedViewController as? UINavigationController {
            /// The view controller that is visible for the preview is a `UINavigationController`.
            /// For the preview, hide its navigation bar.
            selectedNavigationController.setNavigationBarHidden(true, animated: false)
        }

        return poiTabBarController
    }
}

extension MapViewController: UIViewControllerPreviewingDelegate {
    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard
            let tappedObject = mapView.editorLayer.osmHitTest(location, radius: 10, testNodes: false, ignoreList: [], segment: nil),
            let tappedNode = tappedObject.isNode()
        else {
            /// Only display a preview for nodes.
            return nil
        }
        
        return viewControllerForPreviewingNode(tappedNode)
    }
    
    public func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        if let poiTabBarViewController = viewControllerToCommit as? POITabBarController {
            if let selectedNode = poiTabBarViewController.selection as? OsmNode {
                /// Make sure that the node is selected when the user dismisses the tab bar view controller again.
                mapView.editorLayer.selectedNode = selectedNode
                mapView.placePushpinForSelection()
            }
            
            /// Show the tab bar.
            poiTabBarViewController.tabBar.isHidden = false
            
            if let selectedNavigationController = poiTabBarViewController.selectedViewController as? UINavigationController {
                /// For previewing, we have hidden the navigation bar, so we need to make it visible again.
                selectedNavigationController.setNavigationBarHidden(false, animated: false)
            }
        }
        
        present(viewControllerToCommit, animated: true)
    }
    
    
}
