//
//  DashboardView.swift
//  DriveAssist
//
//  Created by Godwin A on 02/08/2023.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import SwiftUI
import DriveAssistCore
import DriveAssistDesign

/// The main dashboard screen of the application.
///
/// Displays real-time metrics (Speed, RPM) and current location status.
/// Also provides a manual trigger for the Emergency SOS flow.
public struct DashboardView: View {
    
    /// The ViewModel managing state for this view.
    @StateObject var viewModel: DashboardViewModel
    
    /// State controlling the presentation of the Emergency sheet.
    @State private var showingEmergency = false
    
    /// Initializes the view with a ViewModel.
    ///
    /// - Parameter viewModel: The logic controller for the dashboard.
    public init(viewModel: DashboardViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        NavigationView {
            ZStack {
                // Global Background
                DAColor.background.edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    // Header
                    HStack {
                        Text("DriveAssist")
                            .font(DATypography.header)
                            .foregroundColor(DAColor.textPrimary)
                        Spacer()
                        if viewModel.isEmergencyActive {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.title)
                                .foregroundColor(DAColor.criticalAlert)
                                .automotiveGlow(color: DAColor.criticalAlert)
                        }
                    }
                    .padding()
                    
                    // Metrics Grid (Gauges)
                    HStack(spacing: 10) {
                        CircularGauge(
                            value: viewModel.speed,
                            maxValue: 240,
                            unit: "km/h",
                            title: "SPEED",
                            color: DAColor.brandPrimary
                        )
                        
                        CircularGauge(
                            value: viewModel.rpm,
                            maxValue: 8000,
                            unit: "rpm",
                            title: "ENGINE",
                            color: DAColor.warning
                        )
                    }
                    .padding()
                    
                    // Location Info
                    VStack {
                        Text("CURRENT LOCATION")
                            .font(DATypography.caption)
                            .foregroundColor(DAColor.textSecondary)
                        
                        Text(viewModel.locationName)
                            .font(DATypography.body)
                            .foregroundColor(DAColor.textPrimary)
                            .padding(.top, 2)
                    }
                    .padding()
                    .background(DAColor.surface)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    // Manual SOS Button
                    Button(action: {
                        showingEmergency = true
                    }) {
                        HStack {
                            Image(systemName: "exclamationmark.shield.fill")
                            Text("MANUAL SOS")
                        }
                        .font(DATypography.header)
                        .foregroundColor(DAColor.textPrimary)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(DAColor.criticalAlert)
                        .cornerRadius(16)
                        .shadow(color: DAColor.criticalAlert.opacity(0.4), radius: 10, x: 0, y: 5)
                    }
                    .padding()
                }
            }
            #if os(iOS)
            .navigationBarHidden(true)
            #endif
            .onAppear {
                viewModel.startMonitoring()
            }
            .onDisappear {
                viewModel.stopMonitoring()
            }
            .onChange(of: viewModel.isEmergencyActive) { isActive in
                if isActive {
                    showingEmergency = true
                }
            }
            #if os(iOS)
            .fullScreenCover(isPresented: $showingEmergency, onDismiss: {
                viewModel.isEmergencyActive = false
            }) {
                EmergencyView()
            }
            #else
            .sheet(isPresented: $showingEmergency, onDismiss: {
                viewModel.isEmergencyActive = false
            }) {
                EmergencyView()
            }
            #endif
        }
    }
}
