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
}

extension MapRouletteClient: MapRouletteClientProtocol {
}
