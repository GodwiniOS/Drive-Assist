//
//  MockOBDService.swift
//  DriveAssist
//
//  Created by Godwin A on 26/05/2019.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import Foundation
import Combine
import DriveAssistCore

/// A mock implementation of `OBDServiceProtocol` for testing without a real car/dongle.
///
/// Simulates the connection flow (Scanning -> Connected) and generates realistic
/// engine RPM and speed values.
public class MockOBDService: OBDServiceProtocol {
    
    /// Holds the current connection state.
    private let _connectionState = CurrentValueSubject<OBDConnectionState, Never>(.disconnected)
    
    /// Publishes simulated vehicle data.
    private let _vehicleData = PassthroughSubject<VehicleData, Never>()
    
    /// Timer for data generation loop.
    private var timer: Timer?
    
    /// Public stream of connection states.
    public var connectionState: AnyPublisher<OBDConnectionState, Never> {
        _connectionState.eraseToAnyPublisher()
    }
    
    /// Public stream of vehicle data.
    public var vehicleData: AnyPublisher<VehicleData, Never> {
        _vehicleData.eraseToAnyPublisher()
    }
    
    /// Initializes the mock service.
    public init() {}
    
    /// Simulates the connection process.
    ///
    /// Transitions from .mid scanning to .connected after a 2-second delay.
    public func connect() {
        _connectionState.send(.scanning)
        
        // Simulate finding device after delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self._connectionState.send(.connected)
            self.startStreamingData()
        }
    }
    
    /// Simulates passing disconnection.
    public func disconnect() {
        timer?.invalidate()
        _connectionState.send(.disconnected)
    }
    
    /// Begins generating fake RPM and speed data.
    private func startStreamingData() {
        var speed = 0.0
        var rpm = 1000.0
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            // Simulate acceleration
            if speed < 100 { speed += 2 } else { speed -= 1 }
            rpm = 1000 + (speed * 30) + Double.random(in: -50...50)
            
            let data = VehicleData(
                rpm: rpm,
                speed: speed,
                timestamp: Date().timeIntervalSince1970
            )
            self._vehicleData.send(data)
        }
    }
}
