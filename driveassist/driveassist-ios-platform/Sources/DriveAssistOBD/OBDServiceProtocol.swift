//
//  OBDServiceProtocol.swift
//  DriveAssist
//
//  Created by Godwin A on 20/10/2021.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import Foundation
import Combine

/// Represents a snapshot of vehicle diagnostics data.
public struct VehicleData {
    /// Engine Speed in Revolutions Per Minute.
    public let rpm: Double
    
    /// Vehicle Speed in km/h.
    public let speed: Double
    
    /// The timestamp of the reading.
    public let timestamp: TimeInterval
    
    /// Initializes a new vehicle data snapshot.
    public init(rpm: Double, speed: Double, timestamp: TimeInterval) {
        self.rpm = rpm
        self.speed = speed
        self.timestamp = timestamp
    }
}

/// Represents the connection state of the OBD dongle.
public enum OBDConnectionState {
    /// No device connected.
    case disconnected
    
    /// Searching for a compatible BLE device.
    case scanning
    
    /// Connected and communicating.
    case connected
    
    /// An error occurred during connection or data transfer.
    case error(String)
}

/// Defines the interface for communicating with an OBD-II adapter.
///
/// Implementations handle the low-level Bluetooth or WiFi communication
/// to extract vehicle metrics.
public protocol OBDServiceProtocol {
    /// Publishes the current connection status.
    var connectionState: AnyPublisher<OBDConnectionState, Never> { get }
    
    /// Publishes live vehicle metrics relative to the current timestamp.
    var vehicleData: AnyPublisher<VehicleData, Never> { get }
    
    /// Initiates a connection to the OBD dongle.
    func connect()
    
    /// Terminates the connection.
    func disconnect()
}
