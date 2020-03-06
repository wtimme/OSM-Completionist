//
//  MapRouletteClient.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 3/6/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import Foundation
import MapRoulette

struct MapRouletteTask {
    let coordinate: CLLocationCoordinate2D
    
    init(clusteredPoint: OrgMaprouletteModelsClusteredPoint) {
        self.coordinate = CLLocationCoordinate2D(mapRoulettePoint: clusteredPoint.point)
    }
}

/// An object that communicates with the MapRoulette API.
protocol MapRouletteClientProtocol {
}

final class MapRouletteClient {
    // MARK: Public properties
    
    static let shared = MapRouletteClient()
    
    // MARK: Private properties
    
    private let maximumBoundingBoxSizeInSquareKilometers: Double
    
    // MARK: Initializer
    
    init(maximumBoundingBoxSizeInSquareKilometers: Double = 10.0) {
        self.maximumBoundingBoxSizeInSquareKilometers = maximumBoundingBoxSizeInSquareKilometers
        
        setupAPIBasePath()
    }
    
    // MARK: Private methods
    
    private func setupAPIBasePath() {
        guard !MapRouletteAPI.basePath.starts(with: "http") else {
            /// The `basePath` already has a protocol. Nothing to do here.
            return
        }
        
        MapRouletteAPI.basePath = "https:\(MapRouletteAPI.basePath)"
    }
    
    private func isRectTooLargeForDownload(_ rect: OSMRect) -> Bool {
        let rectAreaSizeInMeters = SurfaceArea(rect)
        let maximumAreaSizeInMeters = maximumBoundingBoxSizeInSquareKilometers * 1000 * 1000
        
        return rectAreaSizeInMeters > maximumAreaSizeInMeters
    }
}

extension MapRouletteClient: MapRouletteClientProtocol {
}
