//
//  EmergencyView.swift
//  DriveAssist
//
//  Created by Godwin A on 07/08/2019.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import SwiftUI
import DriveAssistCore
import DriveAssistDesign

/// A full-screen alert view presented during a detected crash or manual SOS trigger.
///
/// Features a countdown timer and a large "Cancel" button to prevent false alarms.
public struct EmergencyView: View {
    
    /// The ViewModel managing the countdown and SOS logic.
    @StateObject private var viewModel = EmergencyViewModel()
    
    /// Access to the presentation mode to dismiss the view.
    @Environment(\.presentationMode) var presentationMode
    
    /// Initializes the Emergency View.
    public init() {}
    
    public var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // Keep black background for max contrast
            
            VStack(spacing: 40) {
                if viewModel.emergencySent {
                    VStack(spacing: 20) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 80))
                            .foregroundColor(DAColor.success)
                            .automotiveGlow(color: DAColor.success)
                        
                        Text("Alert Sent")
                            .font(DATypography.alertTitle)
                            .foregroundColor(DAColor.textPrimary)
                        
                        Text("Help is on the way.")
                            .font(DATypography.body)
                            .foregroundColor(DAColor.textSecondary)
                        
                        Button("Dismiss") {
                            presentationMode.wrappedValue.dismiss()
                        }
                        .padding()
                        .frame(minWidth: 150)
                        .background(DAColor.surface)
                        .cornerRadius(8)
                        .foregroundColor(DAColor.textPrimary)
                    }
                } else {
                    Text("CRASH DETECTED")
                        .font(DATypography.alertTitle)
                        .foregroundColor(DAColor.criticalAlert)
                        .automotiveGlow(color: DAColor.criticalAlert)
                    
                    Text("Emergency SOS in")
                        .font(DATypography.header)
                        .foregroundColor(DAColor.textPrimary)
                    
                    Text("\(viewModel.countdownValue)")
                        .font(.system(size: 140, weight: .bold, design: .rounded))
                        .foregroundColor(DAColor.textPrimary)
                        .contentTransition(.numericText(value: Double(viewModel.countdownValue)))
                        .padding()
                        .background(
                            Circle()
                                .stroke(DAColor.criticalAlert, style: StrokeStyle(lineWidth: 10, lineCap: .round, dash: [20, 10]))
                                .frame(width: 280, height: 280)
                                .rotationEffect(.degrees(Double(viewModel.countdownValue) * 36))
                                .animation(.linear, value: viewModel.countdownValue)
                        )
                    
                    // High Contrast Cancel Button
                    Button(action: {
                        viewModel.cancel()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("I'M OK - CANCEL")
                            .font(DATypography.header)
                            .foregroundColor(Color.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: Color.white.opacity(0.3), radius: 10)
                    }
                    .padding(.horizontal, 40)
                }
            }
        }
        .onAppear {
            viewModel.startCountdown()
        }
    }
}
