package com.godwina.driveassist.sensors

import com.godwina.driveassist.core.Logger
import kotlin.math.sqrt

/**
 * An advanced crash detector using Sensor Fusion.
 *
 * This algorithm validates high-impact events by cross-referencing
 * Accelerometer (Force) with Gyroscope (Rotation).
 *
 * **Logic**: A real vehicle crash typically involves a high G-force impact AND a sudden,
 * violent change in orientation (spin/roll).
 */
class SensorFusionDetector(
    private val config: CrashDetectionConfig = CrashDetectionConfig()
) {

    /**
     * Analyzes motion data to determine if a crash occurred.
     * @param data The high-frequency sensor sample.
     * @return True if a crash is detected, False otherwise.
     */
    fun detectCrash(data: MotionData): Boolean {
        // 1. Calculate G-Force Magnitude
        val ax = data.acceleration.x
        val ay = data.acceleration.y
        val az = data.acceleration.z
        val gForce = sqrt(ax * ax + ay * ay + az * az)

        // 2. Calculate Rotation Magnitude
        val rx = data.rotation.x
        val ry = data.rotation.y
        val rz = data.rotation.z
        val rotationRate = sqrt(rx * rx + ry * ry + rz * rz)

        // 3. Sensor Fusion Logic
        // We require SIGNIFICANT impact force
        if (gForce <= config.gForceThreshold) {
            return false
        }

        // AND significant rotational violence.
        // This helps filter out simple "phone fell on carpet" scenarios.
        if (rotationRate > config.rotationThreshold) {
            Logger.error(
                "🚨 DETECTED CRASH VIA FUSION! G: $gForce | Rot: $rotationRate",
                "SensorFusion"
            )
            return true
        } else {
            // Log rejection for debugging
            Logger.debug(
                "⚠️ High G ($gForce) but low rotation ($rotationRate). Likely dropped phone.",
                "SensorFusion"
            )
            return false
        }
    }
}
