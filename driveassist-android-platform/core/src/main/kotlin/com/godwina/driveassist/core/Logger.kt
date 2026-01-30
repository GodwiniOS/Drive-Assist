package com.godwina.driveassist.core

import android.util.Log

/**
 * A lightweight logging utility wrapper around [Log].
 */
object Logger {
    private const val TAG = "DriveAssist"

    /**
     * Logs a message to Logcat.
     */
    fun log(message: String, category: String = "General", type: LogType = LogType.DEBUG) {
        val formattedMsg = "[$category] $message"
        when (type) {
            LogType.DEBUG -> Log.d(TAG, formattedMsg)
            LogType.INFO -> Log.i(TAG, formattedMsg)
            LogType.ERROR -> Log.e(TAG, formattedMsg)
            LogType.WARN -> Log.w(TAG, formattedMsg)
        }
    }

    fun debug(message: String, category: String = "Debug") {
        log(message, category, LogType.DEBUG)
    }

    fun error(message: String, category: String = "Error") {
        log(message, category, LogType.ERROR)
    }
}

enum class LogType {
    DEBUG, INFO, ERROR, WARN
}
