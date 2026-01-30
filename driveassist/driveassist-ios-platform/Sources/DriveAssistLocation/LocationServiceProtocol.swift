//
//  LocationServiceProtocol.swift
//  DriveAssist
//
//  Created by Godwin A on 22/07/2021.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

/// Defines the interface for location tracking services.
///
/// This protocol allows the app to switch between real GPS (CoreLocation)
/// and mock location providers for testing/simulation.
public protocol LocationServiceProtocol {
    
    /// A publisher that emits the device's current location.
    var currentLocation: AnyPublisher<CLLocation, Never> { get }
    
    /// Requests the necessary location permissions from the user.
    func requestPermission()
    
    /// Starts the delivery of location updates.
    func startUpdating()
    
    /// Stops location updates to conserve power.
    func stopUpdating()
}
