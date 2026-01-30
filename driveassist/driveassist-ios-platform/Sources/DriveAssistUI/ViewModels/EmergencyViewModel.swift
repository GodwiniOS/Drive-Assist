//
//  EmergencyViewModel.swift
//  DriveAssist
//
//  Created by Godwin A on 25/10/2024.
//  Copyright © 2018-2026 Godwin A. All rights reserved.
//

import Foundation
import Combine
import DriveAssistCore

/// ViewModel managing the Emergency Countdown flow.
///
/// Handles the countdown timer logic, user cancellation, and the final trigger
/// of the SOS functionality.
@MainActor
public class EmergencyViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    /// Current value of the countdown timer (seconds remaining).
    @Published public var countdownValue: Int
    
    /// Indicates if the countdown UI should be visible/active.
    @Published public var isCountdownActive: Bool = false
    
    /// Indicates if the emergency SOS has been sent/triggered.
    @Published public var emergencySent: Bool = false
    
    // MARK: - Private Properties
    
    private var timer: Timer?
    private let maxCount: Int
    
    // MARK: - Initialization
    
    /// Initializes the ViewModel with defaults from `ConfigurationManager`.
    public init() {
        self.maxCount = Int(ConfigurationManager.shared.emergencyCountDownDuration)
        self.countdownValue = self.maxCount
    }
    
    // MARK: - Public Methods
    
    /// Starts the emergency countdown sequence.
    ///
    /// Resets the timer to the maximum duration and begins ticking down.
    public func startCountdown() {
        self.countdownValue = maxCount
        self.isCountdownActive = true
        self.emergencySent = false
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            Task { @MainActor [weak self] in
                guard let self = self else { return }
                
                if self.countdownValue > 0 {
                    self.countdownValue -= 1
                } else {
                    self.triggerEmergency()
                }
            }
        }
    }
    
    /// Cancels the ongoing countdown.
    ///
    /// Called when the user explicitly taps "Cancel" or "I'm Safe".
    public func cancel() {
        timer?.invalidate()
        timer = nil
        isCountdownActive = false
        Logger.log("Emergency countdown cancelled by user", category: "Emergency")
    }
    
    // MARK: - Private Methods
    
    /// Triggers the actual SOS action when the timer reaches zero.
    private func triggerEmergency() {
        timer?.invalidate()
        timer = nil
        isCountdownActive = false
        emergencySent = true
        Logger.log("TRIGGERING EMERGENCY CALL AND SMS!", category: "Emergency")
        
        // Here we would integrate with the actual phone call logic
        // For MVP, we just set the flag
    }
}
