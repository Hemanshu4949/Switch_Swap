package com.example.switch_swap

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MasterActionRouter(context: Context) : MethodChannel.MethodCallHandler {
    private val coreUtilitiesHandler = CoreUtilitiesHandler(context)
    private val systemModifiersHandler = SystemModifiersHandler(context)
    private val accessibilityNavigationHandler = AccessibilityNavigationHandler(context)
    private val permissionHandler = PermissionHandler(context)
    private val passthroughHandler = PassthroughHandler(context)

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        val method = call.method
        when {
            method == "passthrough_keys" -> {
                passthroughHandler.handle(call, result)
            }
            method == "check_accessibility" || method == "open_accessibility_settings" -> {
                permissionHandler.handle(call, result)
            }
            method.startsWith("sys_") || method.startsWith("nav_") -> {
                accessibilityNavigationHandler.handle(call, result)
            }
            method.startsWith("brightness_") || 
            method.startsWith("bluetooth_") || 
            method.startsWith("dnd_") || 
            method.startsWith("ring_") || 
            method.startsWith("screen_keep_awake") -> {
                systemModifiersHandler.handle(call, result)
            }
            else -> {
                // Everything else (Media, Volume, Vibrate, Flashlight, Intents) goes to CoreUtilitiesHandler
                coreUtilitiesHandler.handle(call, result)
            }
        }
    }
}
