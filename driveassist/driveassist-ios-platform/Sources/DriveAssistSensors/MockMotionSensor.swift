//
//  MockMotionSensor.swift
//  DriveAssist
//
//  Created by Godwin A on 21/02/2023.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import Foundation
import Combine
import CoreMotion
import DriveAssistCore

/// A mock implementation of `MotionSensorProtocol` for testing and simulation.
///
/// This class generates synthetic random motion data and provides a mechanism
/// to manually trigger crash events.
public class MockMotionSensor: MotionSensorProtocol {
    
    /// Publisher for simulated motion data updates.
    private let _motionDataSubject = PassthroughSubject<MotionData, Never>()
    
    /// Publisher for simulated crash events.
    private let _crashSubject = PassthroughSubject<Void, Never>()
    
    /// Internal timer for data generation loop.
    private var timer: Timer?
    
    /// Public publisher for motion data.
    public var motionDataPublisher: AnyPublisher<MotionData, Never> {
        _motionDataSubject.eraseToAnyPublisher()
    }
    
    /// Public publisher for crash events.
    public var crashPublisher: AnyPublisher<Void, Never> {
        _crashSubject.eraseToAnyPublisher()
    }
    
    /// Initializes the mock sensor.
    public init() {}
    
    /// Starts the simulation loop, emitting random data every 0.5 seconds.
    public func startMonitoring() {
        Logger.log("Starting Mock Motion Sensor", category: "Simulation")
        
        // Simulate fake data
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            // Random small movements
            let randomAcc = CMAcceleration(
                x: Double.random(in: -0.1...0.1),
                y: Double.random(in: -0.1...0.1),
                z: Double.random(in: -0.1...0.1)
            )
            
            let data = MotionData(
                acceleration: randomAcc,
                rotation: CMRotationRate(x: 0, y: 0, z: 0),
                timestamp: Date().timeIntervalSince1970
            )
            
            self._motionDataSubject.send(data)
        }
    }
    
    /// Stops the simulation loop.
    public func stopMonitoring() {
        timer?.invalidate()
        timer = nil
    }
    
    /// Manually triggers a crash event for testing purposes.
    ///
    /// Call this method to simulate a high-G impact in the app.
    public func simulateCrash() {
        Logger.log("Simulating Crash Event!", category: "Simulation")
        _crashSubject.send(())
    }
}
