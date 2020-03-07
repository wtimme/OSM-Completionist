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

    @objc(screenPointFromMapPoint:birdsEye:)
    func screenPoint(from mapPoint: OSMPoint, birdsEye: Bool) -> CGPoint

    func layerDidEncounterError(_ error: Error)
}

protocol MapRouletteLayerViewDelegate: class {
    /// Is invoked when the user selected a `MapRouletteTaks` on the map.
    /// - Parameter task: The task that was selected.
    func didSelectMapRouletteTask(_ task: MapRouletteTask)
}

@objc protocol LayerView: class {
    var delegate: LayerViewDelegate? { get set }
    func layout()
    
    /// Tells the layer to update its dynamic content (e. g. by downloading information from a web server)
    func updateDynamicContent()
}

@objcMembers class MapRouletteLayerView: UIView, LayerView {
    
    // MARK: Private properties
    
    private let apiClient: MapRouletteClientProtocol = MapRouletteClient.shared
    private lazy var tasks = Set<MapRouletteTask>()
    
    /// The views for each task.
    private lazy var taskViews = [MapRouletteTask.ID: UIView]()
    
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
    weak var mapRouletteLayerViewDelegate: MapRouletteLayerViewDelegate?
    
    func layout() {
        guard let delegate = delegate else {
            /// In order to layout, we need ot have the delegate for the drawing calculation.
            return
        }
        
        for (taskId, view) in taskViews {
            guard let task = tasks.first(where: { $0.id == taskId }) else {
                /// TODO: Add error handling.
                return
            }
            
            let taskMapPoint = MapPointForLatitudeLongitude(task.coordinate.latitude, task.coordinate.longitude)
            let screenPoint = delegate.screenPoint(from: taskMapPoint, birdsEye: true)
            
            /// Update the view's frame.
            var updatedFrame = view.frame
            updatedFrame.origin = screenPoint
            view.frame = updatedFrame
        }
    }
    
    func updateDynamicContent() {
        guard delegate?.isLayerVisible(self) ?? false else {
            /// If the layer was not visible, there is no need to update the content.
            return
        }
        
        guard let boundingBox = delegate?.screenLongitudeLatitude else { return }
        
        apiClient.tasks(in: boundingBox) { [weak self] result in
            switch result {
            case let .failure(error):
                self?.delegate?.layerDidEncounterError(error)
            case let .success(tasks):
                self?.processTasks(tasks)
            }
        }
    }
    
    // MARK: Private methods
    
    private func setup() {
        /// Implement me
    }
    
    private func processTasks(_ tasksToProcess: [MapRouletteTask]) {
        tasksToProcess.forEach { task in
            /// Store the task.
            tasks.insert(task)
            
            guard !taskViews.keys.contains(task.id) else {
                /// A view for this task already exists.
                return
            }
            
            addViewForTask(task)
            
        }
        
        layout()
    }
    
    private func addViewForTask(_ task: MapRouletteTask) {
        let button = UIButton()
        
        button.setTitle("MR", for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 4
        button.sizeToFit()
        
        button.addTarget(self, action: #selector(didTapTaskButton(_:)), for: .touchUpInside)
        
        button.tag = Int(task.id)
        
        taskViews[task.id] = button
        
        addSubview(button)
    }
    
    @objc private func didTapTaskButton(_ button: UIButton) {
        guard let task = tasks.first(where: { $0.id == button.tag }) else {
            /// Unable to find the task for this button.
            return
        }
        
        mapRouletteLayerViewDelegate?.didSelectMapRouletteTask(task)
    }
}
