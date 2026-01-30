//
//  ConfigurationManager.swift
//  DriveAssist
//
//  Created by Godwin A on 31/01/2020.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import Foundation

/// Manages application-wide configuration settings and environment variables.
///
/// This singleton provides access to static configuration values such as API keys,
/// timeouts, and feature-specific constants. It abstracts the source of these
/// values (e.g., hardcoded, .xcconfig, Info.plist, or Environment variables).
public struct ConfigurationManager {
    
    /// The shared singleton instance of the configuration manager.
    public static let shared = ConfigurationManager()
    
    /// The localized phone number to dial for emergency services.
    /// - Note: In a production app, this should be localized based on the user's region (e.g., 911 vs 112).
    public let supportPhoneNumber = "911"
    
    /// The display name of the application.
    public let appName = "DriveAssist"
    
    /// The duration (in seconds) of the countdown before an emergency is declared.
    public let emergencyCountDownDuration: TimeInterval = 10.0
    
    /// The duration (in seconds) of the SOS countdown before a call is placed.
    public let sosCountDownDuration: TimeInterval = 30.0
    
    /// Initializes a new instance of the configuration manager.
    /// Private to enforce singleton usage, though struct init is internal by default.
    public init() {}
    
    /// Retrieves the API Key for backend services.
    ///
    /// - Returns: The API Key string if found in the process environment, otherwise nil.
    public func getAPIKey() -> String? {
        // In a real app, read from Info.plist or Keychain
        return ProcessInfo.processInfo.environment["DRIVE_ASSIST_API_KEY"]
    }
}
