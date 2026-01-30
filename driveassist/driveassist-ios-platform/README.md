<div align="center">
  <img src="./drive_assist_icon.png" width="180" height="180" alt="DriveAssist Logo" />
  <h1>DriveAssist Platform</h1>
  <p>
    <strong>A World-Class, Modular Telematics & Safety Platform for iOS.</strong>
  </p>
  <p>
    <a href="https://developer.apple.com/swift/"><img src="https://img.shields.io/badge/Swift-5.9-F05138" alt="Swift"></a>
    <a href="https://developer.apple.com/ios/"><img src="https://img.shields.io/badge/iOS-17.0%2B-000000" alt="iOS 17"></a>
    <a href="https://developer.apple.com/carplay/"><img src="https://img.shields.io/badge/CarPlay-Ready-007AFF" alt="CarPlay"></a>
    <img src="https://img.shields.io/badge/Architecture-Clean%20SPM-green" alt="Architecture">
  </p>
</div>

---

## 🏎️ Overview

**DriveAssist** is a premium, safety-critical architecture designed for intelligent vehicle monitoring. More than just a "crash detector", it is a modular platform featuring **Sensor Fusion** algorithms, a custom **Automotive Design System**, and robust **OBD-II** telemetry integration.

### Why "World Class"?
- **🛡️ Safety First**: Uses **Sensor Fusion** (Gyro + Accel) to distinguish real crashes from phone drops.
- **🎨 Automotive UX**: Features a custom `DriveAssistDesign` module with "Safety Red" alerts, high-contrast typography, and fluid speedometer animations.
- **🔌 Modular Core**: Built entirely with Swift Package Manager (SPM) for strict separation of concerns (Sensors vs. UI vs. Core).

---

## 🚀 Key Features

### 1. Advanced Crash Detection
Unlike basic apps that just check G-force, DriveAssist implements a **Sensor Fusion** algorithm:
- **Impact Verification**: Checks for High G-Force (>3G).
- **Rotation Validation**: Cross-references violent rotation (>5 rad/s) to filter false positives.
- `CrashDetectorProtocol` allows swapping logic for Machine Learning models in the future.

### 2. Intelligent Emergency Response
- **Countdown**: 10-second buffer with distinct haptic and visual warnings.
- **Manual Override**: Large, accessible "I'm OK" slide-to-cancel interface.
- **Location Pinning**: Automatically captures coordinates at the moment of impact.

### 3. Telemetry & Connectivity
- **OBD-II Support**: Reads RPM and Speed via Bluetooth LE (ELM327).
- **Simulation Mode**: Fully testable without a car using the built-in `MockOBDService` and `MockMotionSensor`.

---

## 🛠 Project Structure

The codebase is organized into decoupled Swift Packages:

| Module | Description |
|--------|-------------|
| **`DriveAssistCore`** | Foundation utilities, Feature Flags (`ConfigurationManager`), and Logging. |
| **`DriveAssistDesign`** | **[NEW]** The Design System. Contains `DAColor`, `DATypography`, and the `CircularGauge` components. |
| **`DriveAssistSensors`** | CoreMotion wrappers and the `SensorFusionDetector` logic. |
| **`DriveAssistLocation`** | CoreLocation services for speed caching and geocoding. |
| **`DriveAssistOBD`** | CoreBluetooth stack for vehicle communication. |
| **`DriveAssistUI`** | The presentation layer, stitching everything together with SwiftUI. |

---

## 💻 Getting Started

### Prerequisites
- Xcode 15+
- iOS 17+ Simulator or Device

### Installation
1. Clone the repository.
2. Open `DriveAssist-ios-platform.xcodeproj`.
3. If packages are missing, go to `File > Packages > Resolve Package Versions`.
4. Select the **iPhone 16 Simulator**.
5. Press **Run**.

> **Note**: To enable **Simulation Mode** (fake speed/RPM), go to the in-app Settings or launch with argument `-simulationMode YES`.

---

## 📄 License
MIT License. Created by godwina. Copyright © 2018-2026.
