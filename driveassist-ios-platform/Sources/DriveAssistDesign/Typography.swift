//
//  Typography.swift
//  DriveAssist
//
//  Created by Godwin A on 28/01/2026.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import SwiftUI

/// Semantic typography styles for automotive interfaces.
///
/// Wraps standard SwiftUI fonts but semantic naming allows us to swap
/// for custom fonts (e.g., Eurostyle) later without changing call sites.
public struct DATypography {
    
    /// Large, glanceable text for primary metrics (e.g., Speed).
    public static let metricHuge = Font.system(size: 80, weight: .bold, design: .rounded)
    
    /// Headline text for section headers.
    public static let header = Font.system(size: 24, weight: .semibold, design: .default)
    
    /// Standard body text for messages.
    public static let body = Font.system(size: 17, weight: .regular, design: .default)
    
    /// Large alert titles.
    public static let alertTitle = Font.system(size: 34, weight: .heavy, design: .rounded)
    
    /// Small captions for units (km/h) or subtitles.
    public static let caption = Font.system(size: 14, weight: .medium, design: .monospaced)
}

/// A ViewModifier to easily apply the automotive glow effect.
struct AutomotiveGlow: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .shadow(color: color.opacity(0.5), radius: 8, x: 0, y: 0)
    }
}

public extension View {
    func automotiveGlow(color: Color = DAColor.brandPrimary) -> some View {
        self.modifier(AutomotiveGlow(color: color))
    }
}
