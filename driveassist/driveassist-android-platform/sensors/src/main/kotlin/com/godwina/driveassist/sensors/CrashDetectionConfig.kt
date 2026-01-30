package com.godwina.driveassist.sensors

/**
 * Configuration for the crash detection algorithms.
 */
data class CrashDetectionConfig(
    /**
     * The minimum G-force required to trigger a potential crash.
     * Default: 3.0 Gs
     */
    val gForceThreshold: Double = 3.0,

    /**
     * The minimum rotation rate (rad/s) required to confirm a crash.
     * Default: 5.0 rad/s (~286 deg/s).
     */
    val rotationThreshold: Double = 5.0
)
