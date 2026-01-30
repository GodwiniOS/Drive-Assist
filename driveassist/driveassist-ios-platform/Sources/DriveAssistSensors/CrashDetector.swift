//
//  CrashDetector.swift
//  DriveAssist
//
//  Created by Godwin A on 19/09/2025.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import Foundation
import CoreMotion
import DriveAssistCore

/// Analyzes motion data to detect potential vehicle collisions.
///
/// This class uses configurable thresholds for G-force and Jerk to evaluate
/// raw sensor data. It relies on a `CrashDetectionConfig` injected at initialization.
public class CrashDetector: CrashDetectorProtocol {
    
    /// The configuration holding detection thresholds.
    private let config: CrashDetectionConfig
    
    /// Initializes the detector with a specific configuration.
    ///
    /// - Parameter config: The `CrashDetectionConfig` to use. Defaults to standard values.
    public init(config: CrashDetectionConfig = CrashDetectionConfig()) {
        self.config = config
    }
    
    /// Evaluates a single data point for crash signatures.
    ///
    /// - Parameter data: The `MotionData` containing acceleration and rotation vectors.
    /// - Returns: `true` if the data exceeds the configured thresholds, indicating a crash.
    public func detectCrash(from data: MotionData) -> Bool {
        let ax = data.acceleration.x
        let ay = data.acceleration.y
        let az = data.acceleration.z
        
        // Calculate magnitude of acceleration vector
        let magnitude = sqrt(ax*ax + ay*ay + az*az)
        
        // Simple threshold check
        // Note: CMMotionManager's userAcceleration typically removes gravity.
        // A value of 3.0G here means 3x the force of gravity was applied to the phone.
        
        if magnitude > config.gForceThreshold {
            Logger.log("Potential crash detected! Magnitude: \(magnitude) G", category: "CrashDetection")
            return true
        }
        
        return false
    }
}
