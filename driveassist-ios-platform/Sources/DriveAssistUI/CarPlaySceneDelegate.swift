//
//  CarPlaySceneDelegate.swift
//  DriveAssist
//
//  Created by Godwin A on 21/09/2025.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import Foundation
#if os(iOS)
import CarPlay
#endif
import DriveAssistCore

#if os(iOS)
/// Manages the lifecycle of the CarPlay interface.
///
/// This delegate handles the connection and disconnection of the CarPlay scene
/// and constructs the template hierarchy (Dashboard, SOS, etc.).
public class CarPlaySceneDelegate: NSObject, CPTemplateApplicationSceneDelegate {
    
    /// The controller for managing CarPlay templates.
    public var interfaceController: CPInterfaceController?
    
    /// Called when the CarPlay scene connects to the app.
    ///
    /// - Parameters:
    ///   - templateApplicationScene: The scene object.
    ///   - interfaceController: The interface controller to use for pushing templates.
    public func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didConnect interfaceController: CPInterfaceController) {
        self.interfaceController = interfaceController
        Logger.log("CarPlay Connected", category: "CarPlay")
        
        // Build the root template items
        
        // 1. Dashboard Item
        let dashboardItem = CPListItem(text: "Dashboard", detailText: "Speed / RPM")
        dashboardItem.handler = { [weak self] item, completion in
            // Logic to push the dashboard details/grid template would go here
            Logger.log("Dashboard selected", category: "CarPlay")
            completion()
        }
        
        // 2. SOS Item
        let sosItem = CPListItem(text: "Emergency SOS", detailText: "Trigger Emergency")
        sosItem.setImage(UIImage(systemName: "exclamationmark.triangle.fill"))
        sosItem.handler = { [weak self] item, completion in
            // Logic to trigger SOS alert
            Logger.log("SOS selected on CarPlay", category: "CarPlay")
            completion()
        }
        
        // Create List Template as Root
        let listTemplate = CPListTemplate(title: "DriveAssist", sections: [
            CPListSection(items: [dashboardItem, sosItem])
        ])
        
        // Set root template
        interfaceController.setRootTemplate(listTemplate, animated: true, completion: nil)
    }
    
    /// Called when the CarPlay scene disconnects.
    public func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene, didDisconnectInterfaceController interfaceController: CPInterfaceController) {
        self.interfaceController = nil
        Logger.log("CarPlay Disconnected", category: "CarPlay")
    }
}
#endif
