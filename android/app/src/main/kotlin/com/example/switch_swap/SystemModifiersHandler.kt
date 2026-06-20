package com.example.switch_swap

import android.app.NotificationManager
import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothManager
import android.content.Context
import android.media.AudioManager
import android.provider.Settings
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class SystemModifiersHandler(private val context: Context) {
    fun handle(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "brightness_up" -> adjustBrightness(0.1f, result) // pseudo step
            "brightness_down" -> adjustBrightness(-0.1f, result)
            "brightness_max" -> setBrightness(255, result)
            "brightness_min" -> setBrightness(0, result)
            "brightness_auto" -> toggleAutoBrightness(result)
            "screen_keep_awake" -> setScreenTimeout(Int.MAX_VALUE, result)
            "bluetooth_on" -> toggleBluetooth(true, result)
            "bluetooth_off" -> toggleBluetooth(false, result)
            "dnd_on" -> setDnd(NotificationManager.INTERRUPTION_FILTER_NONE, result)
            "dnd_off" -> setDnd(NotificationManager.INTERRUPTION_FILTER_ALL, result)
            "ring_normal" -> setRingerMode(AudioManager.RINGER_MODE_NORMAL, result)
            "ring_vibrate" -> setRingerMode(AudioManager.RINGER_MODE_VIBRATE, result)
            "ring_silent" -> setRingerMode(AudioManager.RINGER_MODE_SILENT, result)
            else -> result.notImplemented()
        }
    }

    private fun setBrightness(value: Int, result: MethodChannel.Result) {
        try {
            if (Settings.System.canWrite(context)) {
                Settings.System.putInt(context.contentResolver, Settings.System.SCREEN_BRIGHTNESS_MODE, Settings.System.SCREEN_BRIGHTNESS_MODE_MANUAL)
                Settings.System.putInt(context.contentResolver, Settings.System.SCREEN_BRIGHTNESS, value)
                result.success(null)
            } else {
                result.error("PERMISSION_DENIED", "Requires WRITE_SETTINGS permission", null)
            }
        } catch (e: Exception) {
            result.error("ERROR", "Failed to set brightness", e.message)
        }
    }

    private fun adjustBrightness(delta: Float, result: MethodChannel.Result) {
        try {
            if (Settings.System.canWrite(context)) {
                val current = Settings.System.getInt(context.contentResolver, Settings.System.SCREEN_BRIGHTNESS, 127)
                val newValue = (current + delta * 255).toInt().coerceIn(0, 255)
                Settings.System.putInt(context.contentResolver, Settings.System.SCREEN_BRIGHTNESS_MODE, Settings.System.SCREEN_BRIGHTNESS_MODE_MANUAL)
                Settings.System.putInt(context.contentResolver, Settings.System.SCREEN_BRIGHTNESS, newValue)
                result.success(null)
            } else {
                result.error("PERMISSION_DENIED", "Requires WRITE_SETTINGS permission", null)
            }
        } catch (e: Exception) {
            result.error("ERROR", "Failed to adjust brightness", e.message)
        }
    }

    private fun toggleAutoBrightness(result: MethodChannel.Result) {
        try {
            if (Settings.System.canWrite(context)) {
                val currentMode = Settings.System.getInt(context.contentResolver, Settings.System.SCREEN_BRIGHTNESS_MODE, Settings.System.SCREEN_BRIGHTNESS_MODE_MANUAL)
                val newMode = if (currentMode == Settings.System.SCREEN_BRIGHTNESS_MODE_AUTOMATIC) {
                    Settings.System.SCREEN_BRIGHTNESS_MODE_MANUAL
                } else {
                    Settings.System.SCREEN_BRIGHTNESS_MODE_AUTOMATIC
                }
                Settings.System.putInt(context.contentResolver, Settings.System.SCREEN_BRIGHTNESS_MODE, newMode)
                result.success(null)
            } else {
                result.error("PERMISSION_DENIED", "Requires WRITE_SETTINGS permission", null)
            }
        } catch (e: Exception) {
            result.error("ERROR", "Failed to toggle auto brightness", e.message)
        }
    }

    private fun setScreenTimeout(timeoutMs: Int, result: MethodChannel.Result) {
        try {
            if (Settings.System.canWrite(context)) {
                Settings.System.putInt(context.contentResolver, Settings.System.SCREEN_OFF_TIMEOUT, timeoutMs)
                result.success(null)
            } else {
                result.error("PERMISSION_DENIED", "Requires WRITE_SETTINGS permission", null)
            }
        } catch (e: Exception) {
            result.error("ERROR", "Failed to set screen timeout", e.message)
        }
    }

    private fun toggleBluetooth(enable: Boolean, result: MethodChannel.Result) {
        try {
            val bluetoothManager = context.getSystemService(Context.BLUETOOTH_SERVICE) as BluetoothManager
            val adapter = bluetoothManager.adapter
            if (adapter != null) {
                if (enable) {
                    @Suppress("DEPRECATION")
                    adapter.enable()
                } else {
                    @Suppress("DEPRECATION")
                    adapter.disable()
                }
                result.success(null)
            } else {
                result.error("UNAVAILABLE", "Bluetooth not supported", null)
            }
        } catch (e: SecurityException) {
            result.error("PERMISSION_DENIED", "Requires BLUETOOTH_CONNECT or BLUETOOTH_ADMIN permission", e.message)
        } catch (e: Exception) {
            result.error("ERROR", "Failed to toggle Bluetooth", e.message)
        }
    }

    private fun setDnd(filter: Int, result: MethodChannel.Result) {
        try {
            val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            if (notificationManager.isNotificationPolicyAccessGranted) {
                notificationManager.setInterruptionFilter(filter)
                result.success(null)
            } else {
                result.error("PERMISSION_DENIED", "Requires ACCESS_NOTIFICATION_POLICY permission", null)
            }
        } catch (e: Exception) {
            result.error("ERROR", "Failed to set DND mode", e.message)
        }
    }

    private fun setRingerMode(mode: Int, result: MethodChannel.Result) {
        try {
            val audioManager = context.getSystemService(Context.AUDIO_SERVICE) as AudioManager
            val notificationManager = context.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            if (mode == AudioManager.RINGER_MODE_SILENT && !notificationManager.isNotificationPolicyAccessGranted) {
                result.error("PERMISSION_DENIED", "Requires ACCESS_NOTIFICATION_POLICY to set silent mode", null)
                return
            }
            audioManager.ringerMode = mode
            result.success(null)
        } catch (e: Exception) {
            result.error("ERROR", "Failed to set ringer mode", e.message)
        }
    }
}
