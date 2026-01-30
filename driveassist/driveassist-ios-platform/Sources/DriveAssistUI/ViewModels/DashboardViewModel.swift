//
//  DashboardViewModel.swift
//  DriveAssist
//
//  Created by Godwin A on 06/11/2018.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import Foundation
import Combine
import DriveAssistCore
import DriveAssistSensors
import DriveAssistLocation
import DriveAssistOBD

/// ViewModel driving the main Dashboard screen.
///
/// This class aggregates data from multiple sources (Sensors, Location, OBD)
/// and exposes published properties for the SwiftUI view to consume.
@MainActor
public class DashboardViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    /// Current vehicle speed in km/h.
    @Published public var speed: Double = 0.0
    
    /// Current Engine RPM.
    @Published public var rpm: Double = 0.0
    
    /// Current Location string representation (Lat, Lon).
    @Published public var locationName: String = "Unknown"
    
    /// Flag indicating if a crash event has been triggered.
    @Published public var isEmergencyActive: Bool = false
    
    // MARK: - Private Properties
    
    /// Set of Combine cancellables to manage memory.
    private var cancellables = Set<AnyCancellable>()
    
    // Dependencies
    
    /// The motion sensor service.
    private let motionSensor: MotionSensorProtocol
    
    /// The location tracking service.
    private let locationService: LocationServiceProtocol
    
    /// The OBD connection service.
    private let obdService: OBDServiceProtocol
    
    // MARK: - Initialization
    
    /// Initializes the ViewModel with injected dependencies.
    ///
    /// - Parameters:
    ///   - motionSensor: Provider for motion/crash data.
    ///   - locationService: Provider for GPS data.
    ///   - obdService: Provider for vehicle metrics.
    public init(
        motionSensor: MotionSensorProtocol,
        locationService: LocationServiceProtocol,
        obdService: OBDServiceProtocol
    ) {
        self.motionSensor = motionSensor
        self.locationService = locationService
        self.obdService = obdService
        
        setupBindings()
    }
    
    // MARK: - Setup
    
    /// Configures Combine bindings to update UI state when services emit data.
    private func setupBindings() {
        // Bind OBD Data
        obdService.vehicleData
            .receive(on: RunLoop.main)
            .sink { [weak self] data in
                self?.speed = data.speed
                self?.rpm = data.rpm
            }
            .store(in: &cancellables)
        
        // Bind Location Data (Simplification: just showing coords for now)
        locationService.currentLocation
            .receive(on: RunLoop.main)
            .sink { [weak self] location in
                self?.locationName = "\(String(format: "%.4f", location.coordinate.latitude)), \(String(format: "%.4f", location.coordinate.longitude))"
            }
            .store(in: &cancellables)
            
        // Bind Crash Detection
        motionSensor.crashPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.isEmergencyActive = true
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Public Methods
    
    /// Starts all underlying services (Sensors, GPS, OBD).
    public func startMonitoring() {
        motionSensor.startMonitoring()
        locationService.startUpdating()
        obdService.connect()
    }
    
    /// Stops all underlying services to save battery.
    public func stopMonitoring() {
        motionSensor.stopMonitoring()
        locationService.stopUpdating()
        obdService.disconnect()
    }
}
