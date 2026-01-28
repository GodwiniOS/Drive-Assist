//
//  FeatureFlagService.swift
//  DriveAssist
//
//  Created by Godwin A on 03/05/2018.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import Foundation

/// Defines the available features that can be toggled within the application.
public enum Feature: String, CaseIterable {
    /// Enables simulation mode, using mock sensors and data instead of real hardware.
    case simulationMode = "simulation_mode"
    
    /// Enables verbose diagnostic logging to the console.
    case diagnosticLogging = "diagnostic_logging"
    
    /// Enables CarPlay integration features.
    case carPlayEnabled = "carplay_enabled"
}

/// A protocol defining the interface for a feature flag management service.
public protocol FeatureFlagServiceProtocol {
    /// Checks if a specific feature is enabled.
    /// - Parameter feature: The feature to check.
    /// - Returns: `true` if enabled, otherwise `false`.
    func isEnabled(_ feature: Feature) -> Bool
    
    /// Sets the enabled state of a feature.
    /// - Parameters:
    ///   - feature: The feature to toggle.
    ///   - enabled: The new state of the feature.
    func setEnabled(_ feature: Feature, enabled: Bool)
}

/// A concrete implementation of `FeatureFlagServiceProtocol` that manages feature flags in memory.
///
/// This service allows runtime toggling of features and parsing of command-line arguments
/// (e.g., for automated testing or specific launch configurations).
public class FeatureFlagService: FeatureFlagServiceProtocol {
    
    /// The shared singleton instance.
    public static let shared = FeatureFlagService()
    
    /// Internal storage for feature flag states.
    private var flags: [Feature: Bool] = [:]
    
    /// Initializes the service with default values and parses launch arguments.
    public init() {
        // Default configuration
        // In a real app, this might read from UserDefaults or a remote config
        flags[.simulationMode] = false // Default to false, can be overridden by launch args
        flags[.diagnosticLogging] = true
        flags[.carPlayEnabled] = true
        
        parseLaunchArguments()
    }
    
    /// Checks if a feature is currently enabled.
    /// - Parameter feature: The feature key.
    /// - Returns: Boolean indicating status.
    public func isEnabled(_ feature: Feature) -> Bool {
        return flags[feature] ?? false
    }
    
    /// Updates the status of a feature flag.
    /// - Parameters:
    ///   - feature: The feature key.
    ///   - enabled: The new status.
    public func setEnabled(_ feature: Feature, enabled: Bool) {
        flags[feature] = enabled
    }
    
    /// Parses process launch arguments to override default flags.
    ///
    /// Checks for arguments like `-simulationMode` to enable specific behaviors at launch.
    private func parseLaunchArguments() {
        let arguments = ProcessInfo.processInfo.arguments
        for arg in arguments {
            if arg == "-simulationMode" {
                flags[.simulationMode] = true
            }
        }
    }
}
