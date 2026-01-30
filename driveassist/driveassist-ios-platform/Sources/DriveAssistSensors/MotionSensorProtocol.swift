//
//  MotionSensorProtocol.swift
//  DriveAssist
//
//  Created by Godwin A on 29/04/2018.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import Foundation
import Combine
import CoreMotion

/// Represents a single snapshot of device motion data.
public struct MotionData {
    /// The 3-axis acceleration vector (G-force).
    public let acceleration: CMAcceleration
    
    /// The 3-axis rotation rate (radians/second).
    public let rotation: CMRotationRate
    
    /// The timestamp of the sensor reading.
    public let timestamp: TimeInterval
    
    /// Initializes a new motion data snapshot.
    public init(acceleration: CMAcceleration, rotation: CMRotationRate, timestamp: TimeInterval) {
        self.acceleration = acceleration
        self.rotation = rotation
        self.timestamp = timestamp
    }
}

/// Abstract interface for a motion sensing service.
///
/// Implementations can be real (using CoreMotion) or mock (using synthetic data).
public protocol MotionSensorProtocol: AnyObject {
    /// Publishes high-frequency motion data updates.
    var motionDataPublisher: AnyPublisher<MotionData, Never> { get }
    
    /// Publishes an event when a crash is detected.
    var crashPublisher: AnyPublisher<Void, Never> { get }
    
    /// Starts monitoring the sensors.
    func startMonitoring()
    
    /// Stops monitoring to conserve battery.
    func stopMonitoring()
}
