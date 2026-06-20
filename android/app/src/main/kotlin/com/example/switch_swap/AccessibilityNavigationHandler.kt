package com.example.switch_swap

import android.accessibilityservice.AccessibilityService
import android.content.Context
import android.os.Build
import android.util.Log
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class AccessibilityNavigationHandler(private val context: Context) {
    
    companion object {
        private const val TAG = "SwitchSwap-NavHandler"
    }

    fun handle(call: MethodCall, result: MethodChannel.Result) {
        Log.i(TAG, "handle: Received method call '${call.method}'")
        try {
            val service = SwitchSwapAccessibilityService.instance
            if (service == null) {
                Log.e(TAG, "handle: Accessibility Service is not running")
                result.error("SERVICE_UNAVAILABLE", "Accessibility Service is not running", null)
                return
            }

            val success = when (call.method) {
                "sys_screenshot" -> {
                    Log.i(TAG, "handle: Executing sys_screenshot")
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                        service.executeGlobalAction(AccessibilityService.GLOBAL_ACTION_TAKE_SCREENSHOT)
                    } else {
                        Log.w(TAG, "handle: sys_screenshot requires Android P+")
                        false
                    }
                }
                "sys_lock_screen" -> {
                    Log.i(TAG, "handle: Executing sys_lock_screen")
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                        service.executeGlobalAction(AccessibilityService.GLOBAL_ACTION_LOCK_SCREEN)
                    } else {
                        Log.w(TAG, "handle: sys_lock_screen requires Android P+")
                        false
                    }
                }
                "nav_home" -> {
                    Log.i(TAG, "handle: Executing nav_home")
                    service.executeGlobalAction(AccessibilityService.GLOBAL_ACTION_HOME)
                }
                "nav_back" -> {
                    Log.i(TAG, "handle: Executing nav_back")
                    service.executeGlobalAction(AccessibilityService.GLOBAL_ACTION_BACK)
                }
                "nav_recents" -> {
                    Log.i(TAG, "handle: Executing nav_recents")
                    service.executeGlobalAction(AccessibilityService.GLOBAL_ACTION_RECENTS)
                }
                "sys_notifications" -> {
                    Log.i(TAG, "handle: Executing sys_notifications")
                    service.executeGlobalAction(AccessibilityService.GLOBAL_ACTION_NOTIFICATIONS)
                }
                "sys_quick_settings" -> {
                    Log.i(TAG, "handle: Executing sys_quick_settings")
                    service.executeGlobalAction(AccessibilityService.GLOBAL_ACTION_QUICK_SETTINGS)
                }
                "sys_split_screen" -> {
                    Log.i(TAG, "handle: Executing sys_split_screen")
                    service.executeGlobalAction(AccessibilityService.GLOBAL_ACTION_TOGGLE_SPLIT_SCREEN)
                }
                else -> {
                    Log.w(TAG, "handle: Method '${call.method}' not implemented")
                    result.notImplemented()
                    return
                }
            }

            if (success) {
                Log.i(TAG, "handle: Successfully executed '${call.method}'")
                result.success(null)
            } else {
                Log.e(TAG, "handle: Failed to execute global action '${call.method}'")
                result.error("ACTION_FAILED", "Failed to execute global action or unsupported API level", null)
            }
        } catch (e: Exception) {
            Log.e(TAG, "handle: Error handling '${call.method}'", e)
            result.error("ERROR", "Failed to handle accessibility action", e.message)
        }
    }
}
