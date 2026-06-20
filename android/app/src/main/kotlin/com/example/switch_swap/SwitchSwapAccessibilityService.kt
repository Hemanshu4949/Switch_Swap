package com.example.switch_swap

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityServiceInfo
import android.content.Intent
import android.util.Log
import android.view.KeyEvent
import android.view.accessibility.AccessibilityEvent
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.FlutterInjector
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class SwitchSwapAccessibilityService : AccessibilityService() {

    companion object {
        var instance: SwitchSwapAccessibilityService? = null
        const val HARDWARE_EVENT_ACTION = "com.example.switch_swap.HARDWARE_EVENT"
        const val EXTRA_KEY_CODE = "keyCode"
        private const val TAG = "SwitchSwap-Native"
    }

    private var flutterEngine: FlutterEngine? = null
    private var methodChannel: MethodChannel? = null

    override fun onServiceConnected() {
        super.onServiceConnected()
        Log.i(TAG, "onServiceConnected: Service is connecting...")
        instance = this

        // The OEM Bug Fix: dynamically force the key filter flag
        val info = serviceInfo ?: AccessibilityServiceInfo()
        info.flags = info.flags or AccessibilityServiceInfo.FLAG_REQUEST_FILTER_KEY_EVENTS
        serviceInfo = info
        
        Log.i(TAG, "1. ACCESSIBILITY SERVICE CONNECTED & FLAGS FORCED")

        // Ensure Flutter loader is ready
        val loader = FlutterInjector.instance().flutterLoader()
        if (!loader.initialized()) {
            Log.i(TAG, "onServiceConnected: Initializing FlutterLoader")
            loader.startInitialization(this)
            loader.ensureInitializationComplete(this, emptyArray())
        }

        // Spawn the headless engine pointing to our new Dart entry point
        Log.i(TAG, "onServiceConnected: Spawning Headless FlutterEngine")
        flutterEngine = FlutterEngine(this)
        GeneratedPluginRegistrant.registerWith(flutterEngine!!)
        flutterEngine?.dartExecutor?.executeDartEntrypoint(
            DartExecutor.DartEntrypoint(
                loader.findAppBundlePath(),
                "package:switch_swap/core/engine/headless_engine.dart",
                "headlessTask"
            )
        )

        // Bind the MethodChannel to THIS background engine, not the UI engine
        Log.i(TAG, "onServiceConnected: Binding MethodChannel")
        methodChannel = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, "com.example.switch_swap/actions")

        // Attach the MasterActionRouter (which includes passthrough + all system actions)
        Log.i(TAG, "onServiceConnected: Setting MasterActionRouter on MethodChannel")
        methodChannel?.setMethodCallHandler(MasterActionRouter(this))
        
        Log.i(TAG, "Headless Flutter Engine Spawned and Channel Bound.")
    }

    override fun onUnbind(intent: Intent?): Boolean {
        Log.i(TAG, "onUnbind: Service is unbinding")
        instance = null
        return super.onUnbind(intent)
    }

    override fun onKeyEvent(event: KeyEvent): Boolean {
        Log.d(TAG, "onKeyEvent: Received event with keyCode=${event.keyCode}, action=${event.action}")
        
        // Check if event.keyCode is KEYCODE_VOLUME_UP or KEYCODE_VOLUME_DOWN
        if (event.keyCode == KeyEvent.KEYCODE_VOLUME_UP || event.keyCode == KeyEvent.KEYCODE_VOLUME_DOWN) {
            
            // Only proceed if event.action == ACTION_DOWN to prevent double firing
            if (event.action == KeyEvent.ACTION_DOWN) {
                Log.i(TAG, "2. PHYSICAL KEY CAPTURED - KeyCode: ${event.keyCode}")
                
                // Pipe directly to the background Flutter Isolate
                Log.i(TAG, "onKeyEvent: Invoking 'onHardwareEvent' on MethodChannel")
                methodChannel?.invokeMethod("onHardwareEvent", mapOf("keyCode" to event.keyCode), object : MethodChannel.Result {
                    override fun success(result: Any?) {
                        Log.d(TAG, "onHardwareEvent success: $result")
                    }
                    override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                        Log.e(TAG, "onHardwareEvent error: $errorCode, $errorMessage")
                    }
                    override fun notImplemented() {
                        Log.e(TAG, "onHardwareEvent notImplemented: The Dart side did not register the handler!")
                    }
                })
            }
            
            // Return true to consume the event
            Log.d(TAG, "onKeyEvent: Consuming event ${event.keyCode}")
            return true
        }
        
        return super.onKeyEvent(event)
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        // Not needed for dispatching actions
        // Log.v(TAG, "onAccessibilityEvent: Received event type=${event?.eventType}")
    }

    override fun onInterrupt() {
        Log.w(TAG, "onInterrupt: Service interrupted")
    }

    override fun onDestroy() {
        Log.i(TAG, "onDestroy: Service is being destroyed")
        flutterEngine?.destroy()
        flutterEngine = null
        methodChannel?.setMethodCallHandler(null)
        methodChannel = null
        super.onDestroy()
    }

    fun executeGlobalAction(action: Int): Boolean {
        Log.i(TAG, "executeGlobalAction: Attempting to execute global action $action")
        val result = performGlobalAction(action)
        Log.i(TAG, "executeGlobalAction: Result for action $action is $result")
        return result
    }
}
