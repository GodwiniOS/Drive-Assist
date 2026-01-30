//
//  SettingsView.swift
//  DriveAssist
//
//  Created by Godwin A on 03/05/2025.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import SwiftUI
import DriveAssistCore

/// A settings configuration screen for the application.
///
/// Allows users to toggle features like Simulation Mode and view app information.
public struct SettingsView: View {
    
    /// Binding to the local state, backed by the global FeatureFlagService.
    @State private var simulationMode: Bool
    
    /// Initializes the settings view, loading initial values from the service.
    public init() {
         _simulationMode = State(initialValue: FeatureFlagService.shared.isEnabled(.simulationMode))
    }
    
    public var body: some View {
        Form {
            Section(header: Text("General")) {
                Toggle("Simulation Mode", isOn: $simulationMode)
                    .onChange(of: simulationMode) { newValue in
                        FeatureFlagService.shared.setEnabled(.simulationMode, enabled: newValue)
                    }
            }
            
            Section(header: Text("About")) {
                Text("Version 1.0.0")
            }
        }
        .navigationTitle("Settings")
    }
}
