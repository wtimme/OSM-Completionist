//
//  MapRouletteLayerView.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 2/14/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import UIKit

protocol LayerViewDelegate: class {
    var screenLongitudeLatitude: OSMRect { get }
}

class MapRouletteLayerView: UIView {
    
    // MARK: Public properties
    
    weak var delegate: LayerViewDelegate?
    
    // MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    // MARK: Private methods
    
    private func setup() {
        /// Implement me
    }
}
