//
//  CrashDetectionConfig.swift
//  DriveAssist
//
//  Created by Godwin A on 05/03/2020.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import Foundation

/// Configuration parameters for the crash detection algorithm.
///
/// This struct allows the host application to customize sensitivity thresholds
/// without modifying the core sensor package.
public struct CrashDetectionConfig {
    /// The acceleration threshold in G-force units required to trigger a potential crash.
    /// Default is 3.0 G.
    public let gForceThreshold: Double
    
    /// The jerk (rate of change of acceleration) threshold.
    /// Default is 200.0 (placeholder unit).
    public let jerkThreshold: Double
    
    /// Initializes a new configuration with custom thresholds.
    ///
    /// - Parameters:
    ///   - gForceThreshold: Minimum G-force (default: 3.0).
    ///   - jerkThreshold: Minimum Jerk (default: 200.0).
    public init(gForceThreshold: Double = 3.0, jerkThreshold: Double = 200.0) {
        self.gForceThreshold = gForceThreshold
        self.jerkThreshold = jerkThreshold
    }
}
