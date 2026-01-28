//
//  RealMotionSensor.swift
//  DriveAssist
//
//  Created by Godwin A on 06/05/2024.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import Foundation
import Combine
import CoreMotion
import DriveAssistCore

#if os(iOS)
/// A concrete implementation of `MotionSensorProtocol` using the device's hardware sensors via CoreMotion.
///
/// This class feeds raw accelerometer data into a `CrashDetector` to identify impacts.
public class RealMotionSensor: MotionSensorProtocol {
    
    /// The system motion manager.
    private let motionManager = CMMotionManager()
    
    /// The logic unit for detecting crashes.
    private let crashDetector: CrashDetectorProtocol
    
    /// Publisher subject for motion data.
    private let _motionDataSubject = PassthroughSubject<MotionData, Never>()
    
    /// Publisher subject for crash events.
    private let _crashSubject = PassthroughSubject<Void, Never>()
    
    /// Public stream of motion data.
    public var motionDataPublisher: AnyPublisher<MotionData, Never> {
        _motionDataSubject.eraseToAnyPublisher()
    }
    
    /// Public stream of crash events.
    public var crashPublisher: AnyPublisher<Void, Never> {
        _crashSubject.eraseToAnyPublisher()
    }

    /// Initializes the sensor with a configuration.
    ///
    /// - Parameter config: Configuration for the internal crash detector.
    public init(config: CrashDetectionConfig = CrashDetectionConfig()) {
        // Upgrade: Defaulting to SensorFusionDetector for world-class safety.
        self.crashDetector = SensorFusionDetector(config: config)
    }
    
    /// Starts pulling data from the CoreMotion hardware.
    ///
    /// Sets the update interval to 10Hz to balance responsiveness with battery life.
    public func startMonitoring() {
        guard motionManager.isDeviceMotionAvailable else {
            Logger.error("Device Motion is not available on this device", category: "Sensors")
            return
        }
        
        motionManager.deviceMotionUpdateInterval = 0.1 // 10Hz
        
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (motion, error) in
            guard let self = self, let motion = motion else { return }
            
            let data = MotionData(
                acceleration: motion.userAcceleration, // Use userAcceleration to filter out gravity
                rotation: motion.rotationRate,
                timestamp: motion.timestamp
            )
            
            self._motionDataSubject.send(data)
            
            if self.crashDetector.detectCrash(from: data) {
                 // in a real implementation we might debounce this
                 self._crashSubject.send(())
            }
        }
    }
    
    /// Stops hardware updates.
    public func stopMonitoring() {
        motionManager.stopDeviceMotionUpdates()
    }
}
#endif
