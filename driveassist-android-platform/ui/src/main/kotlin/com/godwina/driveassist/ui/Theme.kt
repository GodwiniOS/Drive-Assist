package com.godwina.driveassist.ui

import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.runtime.Composable

@Composable
fun DriveAssistTheme(
    content: @Composable () -> Unit
) {
    val colorScheme = darkColorScheme()
    
    MaterialTheme(
        colorScheme = colorScheme,
        content = content
    )
}
