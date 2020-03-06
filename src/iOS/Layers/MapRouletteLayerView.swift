//
//  MapRouletteLayerView.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 2/14/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import UIKit

@objc protocol LayerViewDelegate: class {
    func isLayerVisible(_ layerView: LayerView) -> Bool
    var screenLongitudeLatitude: OSMRect { get }
}

@objc protocol LayerView: class {
    var delegate: LayerViewDelegate? { get set }
    func layout()
}

@objcMembers class MapRouletteLayerView: UIView, LayerView {
    
    // MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    // MARK: LayerView
    
    weak var delegate: LayerViewDelegate?
    
    func layout() {
        /// TODO: Implement me.
    }
    
    // MARK: Private methods
    
    private func setup() {
        /// Implement me
    }
}
