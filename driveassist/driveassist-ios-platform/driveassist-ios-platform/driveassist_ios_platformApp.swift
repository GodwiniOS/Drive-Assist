//
//  driveassist_ios_platformApp.swift
//  driveassist-ios-platform
//
//  Created by Godwin A on 28/01/26.
//

import SwiftUI
import DriveAssistUI

@main
struct driveassist_ios_platformApp: App {
    var body: some Scene {
        WindowGroup {
            AppFactory.makeDashboardView()
        }
    }
}
