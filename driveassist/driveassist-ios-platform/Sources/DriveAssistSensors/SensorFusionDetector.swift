//
//  SensorFusionDetector.swift
//  DriveAssist
//
//  Created by Godwin A on 28/01/2026.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import Foundation
import CoreMotion
import DriveAssistCore

/// An advanced crash detector using Sensor Fusion.
///
/// This algorithm validates high-impact events by cross-referencing
/// Accelerometer (Force) with Gyroscope (Rotation).
///
/// **Logic**: A real vehicle crash typically involves a high G-force impact AND a sudden,
/// violent change in orientation (spin/roll).
/// A phone drop usually has high G (impact) but less coordinated/sustained rotation profile,
/// or free-fall (0G) preceding it.
public class SensorFusionDetector: CrashDetectorProtocol {
    
    private let config: CrashDetectionConfig
    
    /// Threshold for rotation rate in radians/sec.
    /// 5.0 rad/s is extremely fast (~286 deg/s), indicative of violent spins.
    private let rotationThreshold: Double = 5.0
    
    public init(config: CrashDetectionConfig = CrashDetectionConfig()) {
        self.config = config
    }
    
    public func detectCrash(from data: MotionData) -> Bool {
        // 1. Calculate G-Force Magnitude
        let ax = data.acceleration.x
        let ay = data.acceleration.y
        let az = data.acceleration.z
        let gForce = sqrt(ax*ax + ay*ay + az*az)
        
        // 2. Calculate Rotation Magnitude
        let rx = data.rotation.x
        let ry = data.rotation.y
        let rz = data.rotation.z
        let rotationRate = sqrt(rx*rx + ry*ry + rz*rz)
        
        // 3. Sensor Fusion Logic
        // We require SIGNIFICANT impact force
        guard gForce > config.gForceThreshold else { return false }
        
        // AND significant rotational violence.
        // This helps filter out simple "phone fell on carpet" scenarios where
        // the phone might stop abruptly but doesn't experience the violent
        // shearing torque of a car crash.
        if rotationRate > rotationThreshold {
            Logger.log("🚨 DETECTED CRASH VIA FUSION! G: \(gForce) | Rot: \(rotationRate)", category: "SensorFusion")
            return true
        } else {
            // Log rejection for debugging
            Logger.log("⚠️ High G (\(gForce)) but low rotation (\(rotationRate)). Likely dropped phone.", category: "SensorFusion")
            return false
        }
    }
}
