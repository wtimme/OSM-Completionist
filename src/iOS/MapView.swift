//
//  MapView.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 2/14/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

@objc extension MapView {
    func setupMapRouletteLayer() {
        guard nil == self.mapRouletteLayerView else {
            /// Only setup the layer once.
            return
        }
        
        let layerView = MapRouletteLayerView()
        layerView.translatesAutoresizingMaskIntoConstraints = false
        
        insertSubview(layerView, belowSubview: editControl)
        
        NSLayoutConstraint.activate([
            layerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            layerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            layerView.topAnchor.constraint(equalTo: self.topAnchor),
            layerView.bottomAnchor.constraint(equalTo: viewController.toolbar.topAnchor)
        ])
        
        layerView.mapRouletteLayerViewDelegate = viewController
        
        self.mapRouletteLayerView = layerView
    }
}
