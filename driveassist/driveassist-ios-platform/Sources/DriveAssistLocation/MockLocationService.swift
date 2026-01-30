//
//  MockLocationService.swift
//  DriveAssist
//
//  Created by Godwin A on 28/09/2025.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import Foundation
import Combine
import CoreLocation
import DriveAssistCore

/// A mock implementation of `LocationServiceProtocol` that simulates a moving vehicle.
///
/// This service generates a sequence of coordinates simulating a drive along a path,
/// useful for testing UI updates and SOS logic without physically moving.
public class MockLocationService: LocationServiceProtocol {
    
    /// Publisher subject for location updates.
    private let _locationSubject = PassthroughSubject<CLLocation, Never>()
    
    /// Timer to generate periodic updates.
    private var timer: Timer?
    
    /// Public stream of simulated locations.
    public var currentLocation: AnyPublisher<CLLocation, Never> {
        _locationSubject.eraseToAnyPublisher()
    }
    
    /// Initializes the mock service.
    public init() {}
    
    /// Simulates a permission request by logging to the console.
    public func requestPermission() {
        Logger.log("Mock Location Requesting Permission...", category: "Simulation")
    }
    
    /// Starts the simulated drive loop.
    ///
    /// Generates new coordinates starting from San Francisco every second.
    public func startUpdating() {
        Logger.log("Starting Mock Location Updates", category: "Simulation")
        // Simulate driving starting near San Francisco
        var lat = 37.7749
        var lon = -122.4194
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            // Simulate moving north-east
            lat += 0.0001
            lon += 0.0001
            let loc = CLLocation(latitude: lat, longitude: lon)
            self?._locationSubject.send(loc)
        }
    }
    
    /// Stops the simulated drive.
    public func stopUpdating() {
        timer?.invalidate()
        timer = nil
    }
}
