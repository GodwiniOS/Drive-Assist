package com.godwina.driveassist

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import com.godwina.driveassist.ui.screens.DashboardScreen
import com.godwina.driveassist.ui.theme.DriveAssistColors

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            DashboardScreen()
        }
    }
}
