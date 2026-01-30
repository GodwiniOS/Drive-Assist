package com.godwina.driveassist.sensors

/**
 * Represents a 3-axis vector (X, Y, Z).
 */
data class Vector3(
    val x: Double,
    val y: Double,
    val z: Double
)

/**
 * Combined high-frequency motion data.
 * @param timestamp System timestamp in nanoseconds.
 * @param acceleration G-Force vector (Gravity may or may not be included based on sensor type).
 * @param rotation Rotation rate in rad/s.
 */
data class MotionData(
    val timestamp: Long,
    val acceleration: Vector3,
    val rotation: Vector3
)
