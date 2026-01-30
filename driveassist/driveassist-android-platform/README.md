# DriveAssist Android Platform

**DriveAssist Android** is the native implementation of the DriveAssist Telematics & Safety Platform. It brings the same world-class safety features from iOS to the Android ecosystem, built with modern **Kotlin** and **Jetpack Compose**.

<div align="center">
  <img src="https://img.shields.io/badge/Kotlin-1.9-7F52FF" alt="Kotlin">
  <img src="https://img.shields.io/badge/Compose-Material3-4285F4" alt="Compose">
  <img src="https://img.shields.io/badge/Architecture-Clean%20Multi--Module-green" alt="Architecture">
</div>

---

## 🏗️ Architecture

The project follows a **Multi-Module Clean Architecture** to ensure scalability and strict separation of concerns, mirroring the iOS SPM structure.

| Module | Purpose | Tech Stack |
|--------|---------|------------|
| **`:app`** | Main entry point and DI Graph. | `Hilt` (Planned), `Activity` |
| **`:core`** | Shared utilities, Models, Config. | `Coroutines`, `Flow` |
| **`:sensors`** | **Sensor Fusion** Logic (Acc + Gyro). | `SensorManager` |
| **`:obd`** | Bluetooth OBD-II communication. | `Android Bluetooth API` |
| **`:ui`** | Reusable Design System. | `Jetpack Compose` |

---

## 🚀 Key Features (In Development)

### 1. Sensor Fusion Safety
Implements the same rigorous **Impact + Rotation** algorithm as the iOS platform to distinguish true crashes from phone drops.

### 2. Modern UI
Built entirely with **Jetpack Compose** using Material 3, featuring custom drawn Canvas components (Speedometer, Gauges) for high-performance rendering.

### 3. Bluetooth Low Energy
Direct communication with ELM327 OBD-II dongles to read real-time RPM and Speed.

---

## 💻 Getting Started

### Prerequisites
- Android Studio Iguana or newer.
- JDK 17.
- Android Device (Min SDK 26).

### Installation
1. Open the `driveassist-android-platform` folder in Android Studio.
2. Sync Gradle files.
3. Select `app` configuration and Run.

---

## 📄 License
MIT License. Created by godwina. Copyright © 2018-2026.
