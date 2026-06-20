// REQUIRED PERMISSIONS IN AndroidManifest.xml:
// <uses-permission android:name="android.permission.CAMERA" />
// <uses-permission android:name="android.permission.VIBRATE" />
// <uses-permission android:name="android.permission.QUERY_ALL_PACKAGES" /> // Required for Android 11+ to launch arbitrary apps
// <uses-permission android:name="android.permission.WRITE_SETTINGS" />
// <uses-permission android:name="android.permission.ACCESS_NOTIFICATION_POLICY" />
// <uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />

package com.example.switch_swap

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.provider.Settings
import android.text.TextUtils
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.BroadcastReceiver
import android.content.IntentFilter
import android.util.Log
import androidx.core.content.ContextCompat
import android.os.Build

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.switch_swap/permissions"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "isAccessibilityEnabled" -> {
                    result.success(isAccessibilityEnabled(context))
                }
                "openAccessibilitySettings" -> {
                    try {
                        val intent = Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS)
                        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                        context.startActivity(intent)
                        result.success(null)
                    } catch (e: Exception) {
                        result.error("INTENT_ERROR", "Could not open accessibility settings", e.message)
                    }
                }
                "isOverlayEnabled" -> {
                    result.success(isOverlayEnabled(context))
                }
                "openOverlaySettings" -> {
                    try {
                        val intent = Intent(
                            Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
                            Uri.parse("package:$packageName")
                        )
                        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
                        context.startActivity(intent)
                        result.success(null)
                    } catch (e: Exception) {
                        result.error("INTENT_ERROR", "Could not open overlay settings", e.message)
                    }
                }
                "dispatchMediaKey" -> {
                    // Original implementation left intact for the permissions channel just in case
                    val keyCode = call.argument<Int>("keycode")
                    if (keyCode != null) {
                        try {
                            val audioManager = getSystemService(Context.AUDIO_SERVICE) as android.media.AudioManager
                            val downEvent = android.view.KeyEvent(android.view.KeyEvent.ACTION_DOWN, keyCode)
                            val upEvent = android.view.KeyEvent(android.view.KeyEvent.ACTION_UP, keyCode)
                            audioManager.dispatchMediaKeyEvent(downEvent)
                            audioManager.dispatchMediaKeyEvent(upEvent)

                            val downIntent = Intent(Intent.ACTION_MEDIA_BUTTON)
                            downIntent.putExtra(Intent.EXTRA_KEY_EVENT, downEvent)
                            context.sendOrderedBroadcast(downIntent, null)

                            val upIntent = Intent(Intent.ACTION_MEDIA_BUTTON)
                            upIntent.putExtra(Intent.EXTRA_KEY_EVENT, upEvent)
                            context.sendOrderedBroadcast(upIntent, null)
                            
                            result.success(true)
                        } catch (e: Exception) {
                            result.error("MEDIA_ERROR", "Failed to dispatch media key", e.message)
                        }
                    } else {
                        result.error("INVALID_ARGUMENT", "Keycode is null", null)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
    }

    private fun isAccessibilityEnabled(context: Context): Boolean {
        var accessibilityEnabled = 0
        try {
            accessibilityEnabled = Settings.Secure.getInt(
                context.contentResolver,
                Settings.Secure.ACCESSIBILITY_ENABLED
            )
        } catch (e: Settings.SettingNotFoundException) {
            // Settings not found, ignore and default to 0
        }
        
        if (accessibilityEnabled == 1) {
            val settingValue = Settings.Secure.getString(
                context.contentResolver,
                Settings.Secure.ENABLED_ACCESSIBILITY_SERVICES
            )
            if (settingValue != null) {
                val expectedComponentName = "${context.packageName}/.SwitchSwapAccessibilityService"
                val splitter = TextUtils.SimpleStringSplitter(':')
                splitter.setString(settingValue)
                while (splitter.hasNext()) {
                    val componentName = splitter.next()
                    if (componentName.contains(context.packageName, ignoreCase = true)) {
                        return true
                    }
                }
            }
        }
        return false
    }

    private fun isOverlayEnabled(context: Context): Boolean {
        return Settings.canDrawOverlays(context)
    }
}
