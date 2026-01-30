//
//  CrashDetectorProtocol.swift
//  DriveAssist
//
//  Created by Godwin A on 28/01/2026.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import Foundation

/// Protocol defining the contract for crash detection algorithms.
///
/// Implementations can vary from simple G-force threshold checks to complex
/// Sensor Fusion or Machine Learning models.
public protocol CrashDetectorProtocol {
    /// Analyzes a motion data point to determine if a crash occurred.
    /// - Parameter data: The instantaneous motion data (accel, gyro, etc).
    /// - Returns: `true` if a crash is detected.
    func detectCrash(from data: MotionData) -> Bool
}
