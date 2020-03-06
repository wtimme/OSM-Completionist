//
//  CLLocationCoordinate2D+MapRoulette.swift
//  Go Map!!
//
//  Created by Wolfgang Timme on 3/6/20.
//  Copyright © 2020 Bryce. All rights reserved.
//

import CoreLocation
import MapRoulette

extension CLLocationCoordinate2D {
    init(mapRoulettePoint: OrgMaprouletteModelsPoint) {
        self.init(latitude: mapRoulettePoint.lat,
                  longitude: mapRoulettePoint.lng)
    }
}
