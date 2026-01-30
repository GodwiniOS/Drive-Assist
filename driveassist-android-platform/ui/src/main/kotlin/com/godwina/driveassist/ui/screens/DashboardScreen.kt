package com.godwina.driveassist.ui.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.godwina.driveassist.ui.components.CircularGauge
import com.godwina.driveassist.ui.theme.DriveAssistColors

@Composable
fun DashboardScreen() {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(DriveAssistColors.Background)
            .padding(24.dp)
    ) {
        // Header
        Text(
            text = "DriveAssist",
            color = DriveAssistColors.TextPrimary,
            fontSize = 34.sp,
            fontWeight = FontWeight.Bold
        )
        Text(
            text = "Android Platform",
            color = DriveAssistColors.TextSecondary,
            fontSize = 16.sp
        )

        Spacer(modifier = Modifier.height(48.dp))

        // Gauges Row
        Row {
            CircularGauge(
                value = 0.0,
                maxValue = 240.0,
                label = "SPEED",
                unit = "km/h",
                primaryColor = DriveAssistColors.BrandPrimary,
                modifier = Modifier.weight(1f)
            )

            Spacer(modifier = Modifier.width(16.dp))

            CircularGauge(
                value = 0.0,
                maxValue = 8000.0,
                label = "RPM",
                unit = "rpm",
                primaryColor = DriveAssistColors.Warning,
                modifier = Modifier.weight(1f)
            )
        }
        
        Spacer(modifier = Modifier.weight(1f))
        
        Text(
            text = "Basic UI Scaffolding Complete",
            color = DriveAssistColors.CriticalAlert,
            fontSize = 12.sp,
            modifier = Modifier.padding(bottom = 32.dp)
        )
    }
}
