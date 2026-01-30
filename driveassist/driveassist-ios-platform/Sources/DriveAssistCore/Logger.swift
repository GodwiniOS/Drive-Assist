//
//  Logger.swift
//  DriveAssist
//
//  Created by Godwin A on 13/10/2022.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import Foundation
import os.log

/// A lightweight logging utility wrapper around `os.log`.
///
/// This struct provides static methods for logging messages with different severity levels,
/// conditionally based on the `diagnosticLogging` feature flag.
public struct Logger {
    /// The subsystem identifier for OSLog, used to filter logs in Console.app.
    private static let subsystem = "com.driveassist.platform"
    
    /// Logs a message to the system console.
    ///
    /// - Parameters:
    ///   - message: The text message to log.
    ///   - category: A category string to organize logs (e.g., "Network", "UI").
    ///   - type: The `OSLogType` (default, info, debug, error, fault).
    public static func log(_ message: String, category: String = "General", type: OSLogType = .default) {
        if FeatureFlagService.shared.isEnabled(.diagnosticLogging) {
            let log = OSLog(subsystem: subsystem, category: category)
            os_log("%{public}@", log: log, type: type, message)
        }
    }
    
    /// Logs a debug-level message.
    ///
    /// - Parameters:
    ///   - message: The debug information.
    ///   - category: Optional category (defaults to "Debug").
    public static func debug(_ message: String, category: String = "Debug") {
        log(message, category: category, type: .debug)
    }
    
    /// Logs an error-level message.
    ///
    /// - Parameters:
    ///   - message: The error description.
    ///   - category: Optional category (defaults to "Error").
    public static func error(_ message: String, category: String = "Error") {
        log(message, category: category, type: .error)
    }
}
