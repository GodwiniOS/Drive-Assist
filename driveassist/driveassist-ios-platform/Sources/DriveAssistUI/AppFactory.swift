//
//  AppFactory.swift
//  DriveAssist
//
//  Created by Godwin A on 02/08/2025.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import Foundation
import SwiftUI
import DriveAssistCore
import DriveAssistSensors
import DriveAssistLocation
import DriveAssistOBD

/// A Composition Root responsible for instantiating the app's object graph.
///
/// This factory handles dependency injection, selecting between real hardware implementations
/// and mock services based on the environment (Simulator vs Device) and feature flags.
@MainActor
public struct AppFactory {
    
    /// Creates the Main Dashboard View with all necessary dependencies.
    ///
    /// - Returns: A fully configured `DashboardView`.
    public static func makeDashboardView() -> DashboardView {
        let isSimulation = FeatureFlagService.shared.isEnabled(.simulationMode)
        let isRealDevice = isRunningOnDevice()
        
        // Dependencies
        let motionSensor: MotionSensorProtocol
        let locationService: LocationServiceProtocol
        let obdService: OBDServiceProtocol
        
        // Dependency Injection Logic
        if isSimulation || !isRealDevice {
            Logger.log("Using SIMULATION services", category: "AppFactory")
            motionSensor = MockMotionSensor()
            locationService = MockLocationService()
            obdService = MockOBDService()
        } else {
            // Real services
            #if os(iOS)
            Logger.log("Using REAL services with App Configuration", category: "AppFactory")
            // Example: Injecting custom thresholds from the App (not hardcoded in package)
            let config = CrashDetectionConfig(gForceThreshold: 3.5, jerkThreshold: 250.0)
            motionSensor = RealMotionSensor(config: config)
            locationService = RealLocationService()
            obdService = RealOBDService()
            #else
            // Fallback for non-iOS builds (e.g. previews on Mac)
            Logger.log("Using MOCK services (Fallback for non-iOS)", category: "AppFactory")
            motionSensor = MockMotionSensor()
            locationService = MockLocationService()
            obdService = MockOBDService()
            #endif
        }
        
        let viewModel = DashboardViewModel(
            motionSensor: motionSensor,
            locationService: locationService,
            obdService: obdService
        )
        
        return DashboardView(viewModel: viewModel)
    }
    
    /// Checks if the app is running on a physical device.
    /// - Returns: `true` if on device, `false` if on Simulator.
    private static func isRunningOnDevice() -> Bool {
        #if targetEnvironment(simulator)
        return false
        #else
        return true
        #endif
    }
}
