//
//  CircularGauge.swift
//  DriveAssist
//
//  Created by Godwin A on 28/01/2026.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import SwiftUI

/// A reusable circular gauge component for visualization of metrics (RPM, Speed).
///
/// Features a background track, a fill arc based on value, and a central label.
public struct CircularGauge: View {
    /// The current value to display (e.g. 50).
    public var value: Double
    
    /// The minimum scale value (e.g. 0).
    public var minValue: Double = 0
    
    /// The maximum scale value (e.g. 100).
    public var maxValue: Double = 100
    
    /// The label for the center (e.g. "km/h").
    public var unit: String
    
    /// The visual title (e.g. "SPEED").
    public var title: String
    
    /// The primary color of the filled arc.
    public var color: Color
    
    public init(value: Double, minValue: Double = 0, maxValue: Double = 100, unit: String, title: String, color: Color = DAColor.brandPrimary) {
        self.value = value
        self.minValue = minValue
        self.maxValue = maxValue
        self.unit = unit
        self.title = title
        self.color = color
    }
    
    public var body: some View {
        ZStack {
            // Background Track
            Circle()
                .trim(from: 0.15, to: 0.85)
                .stroke(DAColor.surface.opacity(0.5), style: StrokeStyle(lineWidth: 15, lineCap: .round))
                .rotationEffect(.degrees(90))
            
            // Fill Track
            Circle()
                .trim(from: 0.15, to: 0.15 + (CGFloat(files_normalizedValue) * 0.7))
                .stroke(color, style: StrokeStyle(lineWidth: 15, lineCap: .round))
                .rotationEffect(.degrees(90))
                .animation(.spring(response: 0.5, dampingFraction: 0.6), value: value)
                .automotiveGlow(color: color)
            
            // Central Info
            VStack {
                Text(title.uppercased())
                    .font(DATypography.caption)
                    .foregroundColor(DAColor.textSecondary)
                
                Text(String(format: "%.0f", value))
                    .font(DATypography.metricHuge)
                    .scaleEffect(0.6) // Slightly smaller for inside gauge
                    .foregroundColor(DAColor.textPrimary)
                    .contentTransition(.numericText(value: value))
                
                Text(unit.uppercased())
                    .font(DATypography.caption)
                    .foregroundColor(DAColor.textSecondary)
            }
        }
        .padding()
    }
    
    private var files_normalizedValue: Double {
        let clamped = min(max(value, minValue), maxValue)
        return (clamped - minValue) / (maxValue - minValue)
    }
}
