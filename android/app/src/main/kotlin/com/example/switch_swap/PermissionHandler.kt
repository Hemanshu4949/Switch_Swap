package com.example.switch_swap

import android.content.Context
import android.content.Intent
import android.provider.Settings
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class PermissionHandler(private val context: Context) {
    fun handle(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "check_accessibility" -> {
                try {
                    // The most foolproof way to know if our Accessibility Service is actually running
                    // is to simply check if the singleton instance has been bound by the OS.
                    val isEnabled = SwitchSwapAccessibilityService.instance != null
                    result.success(isEnabled)
                } catch (e: Exception) {
                    result.error("ERROR", "Failed to check accessibility permission", e.message)
                }
            }
            "open_accessibility_settings" -> {
                try {
                    val intent = Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS)
                    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                    context.startActivity(intent)
                    result.success(null)
                } catch (e: Exception) {
                    result.error("ERROR", "Failed to open accessibility settings", e.message)
                }
            }
            else -> result.notImplemented()
        }
    }
}
