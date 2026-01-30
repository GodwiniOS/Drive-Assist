//
//  Colors.swift
//  DriveAssist
//
//  Created by Godwin A on 28/01/2026.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import SwiftUI

/// A semantic color palette for the DriveAssist application.
///
/// Designed for high visibility in automotive environments (Day/Night modes).
public struct DAColor {
    
    /// The primary brand color (Electric Blue).
    public static let brandPrimary = Color(hex: 0x007AFF)
    
    /// High-alert color for emergencies (Safety Red).
    public static let criticalAlert = Color(hex: 0xFF3B30)
    
    /// Warning color for non-critical alerts (Amber).
    public static let warning = Color(hex: 0xFFCC00)
    
    /// Success color for connection states (Emerald).
    public static let success = Color(hex: 0x34C759)
    
    /// Background color for dark mode (Deep Asphalt).
    public static let background = Color(hex: 0x1C1C1E)
    
    /// Secondary background for cards/panels (Gunmetal).
    public static let surface = Color(hex: 0x2C2C2E)
    
    /// Primary text color (White for high contrast).
    public static let textPrimary = Color.white
    
    /// Secondary text color (Silver).
    public static let textSecondary = Color(hex: 0x8E8E93)
}

// MARK: - Color Hex Extension
extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
