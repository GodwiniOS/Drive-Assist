//
//  RealLocationService.swift
//  DriveAssist
//
//  Created by Godwin A on 16/01/2024.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import Foundation
import Combine
import CoreLocation
import DriveAssistCore

#if os(iOS)
/// A concrete implementation of `LocationServiceProtocol` using CoreLocation.
///
/// This class manages the `CLLocationManager` to fetch high-accuracy GPS coordinates
/// suitable for automotive navigation contexts.
public class RealLocationService: NSObject, LocationServiceProtocol, CLLocationManagerDelegate {
    
    /// The system location manager.
    private let locationManager = CLLocationManager()
    
    /// Publisher subject for location updates.
    private let _locationSubject = PassthroughSubject<CLLocation, Never>()
    
    /// Public stream of live GPS locations.
    public var currentLocation: AnyPublisher<CLLocation, Never> {
        _locationSubject.eraseToAnyPublisher()
    }
    
    /// Initializes the service and configures the location manager.
    public override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.activityType = .automotiveNavigation
    }
    
    /// Requests "When In Use" authorization from the user.
    public func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
        // Or .requestAlwaysAuthorization() if needed for background
    }
    
    /// Starts updating the user's location.
    public func startUpdating() {
        Logger.log("Starting location updates", category: "Location")
        locationManager.startUpdatingLocation()
    }
    
    /// Stops updating location to save power.
    public func stopUpdating() {
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    /// Delegate method called when new locations are available.
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        _locationSubject.send(location)
    }
    
    /// Delegate method called when location services fail.
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Logger.error("Location manager failed: \(error.localizedDescription)", category: "Location")
    }
}
#endif
