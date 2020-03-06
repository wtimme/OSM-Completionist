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
    let id: Int64
    let coordinate: CLLocationCoordinate2D
    
    init(clusteredPoint: OrgMaprouletteModelsClusteredPoint) {
        self.id = clusteredPoint._id
        self.coordinate = CLLocationCoordinate2D(mapRoulettePoint: clusteredPoint.point)
    }
}

/// An object that communicates with the MapRoulette API.
protocol MapRouletteClientProtocol {
    /// Retrieves the `MapRouletteTask`s in the given bounding box.
    /// - Parameters:
    ///   - rect: The rect for which to download the tasks.
    ///   - completion: Closure that is executed when the request completed or an error occurred.
    func tasks(in rect: OSMRect, _ completion: @escaping (Result<[MapRouletteTask], Error>) -> Void)
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
    func tasks(in rect: OSMRect, _ completion: @escaping (Result<[MapRouletteTask], Error>) -> Void) {
        guard !isRectTooLargeForDownload(rect) else {
            /// The area is too large to download.
            return
        }
        
        TaskAPI.getTasksInBoundingBox(_left: rect.origin.x, bottom: rect.origin.y + rect.size.height, _right: rect.origin.x + rect.size.width, top: rect.origin.y) { clusteredPoints, error in
            guard error == nil, let clusteredPoints = clusteredPoints else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    let unknownError = NSError(domain: "de.wtimme.osm-completionist.MapRoulette",
                                               code: -1,
                                               userInfo: [NSLocalizedDescriptionKey: "An unknown error occurred"])
                    completion(.failure(unknownError))
                }
                
                return
            }
            
            let tasks = clusteredPoints.map { MapRouletteTask(clusteredPoint: $0) }
            completion(.success(tasks))
        }
    }
    
}
