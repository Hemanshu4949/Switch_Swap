package com.example.switch_swap

import android.content.Context
import android.content.Intent
import android.hardware.camera2.CameraManager
import android.media.AudioManager
import android.net.Uri
import android.os.Build
import android.os.VibrationEffect
import android.os.Vibrator
import android.os.VibratorManager
import android.view.KeyEvent
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class CoreUtilitiesHandler(private val context: Context) {
    fun handle(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "launch_app_picker" -> {
                try {
                    val targetPackage = call.argument<String>("target")
                    if (targetPackage != null) {
                        val intent = context.packageManager.getLaunchIntentForPackage(targetPackage)
                        if (intent != null) {
                            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                            context.startActivity(intent)
                            result.success(null)
                        } else {
                            result.error("NOT_FOUND", "App not found for package: $targetPackage", null)
                        }
                    } else {
                        result.error("INVALID_ARGUMENT", "Target package is null", null)
                    }
                } catch (e: Exception) {
                    result.error("ERROR", "Failed to launch app", e.message)
                }
            }
            "open_url" -> {
                try {
                    val targetUrl = call.argument<String>("target")
                    if (targetUrl != null) {
                        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(targetUrl))
                        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
                        context.startActivity(intent)
                        result.success(null)
                    } else {
                        result.error("INVALID_ARGUMENT", "Target URL is null", null)
                    }
                } catch (e: Exception) {
                    result.error("ERROR", "Failed to open URL", e.message)
                }
            }
            "flashlight_on" -> {
                try {
                    val cameraManager = context.getSystemService(Context.CAMERA_SERVICE) as CameraManager
                    val cameraId = cameraManager.cameraIdList.firstOrNull { id ->
                        cameraManager.getCameraCharacteristics(id).get(android.hardware.camera2.CameraCharacteristics.FLASH_INFO_AVAILABLE) == true
                    }
                    if (cameraId != null) {
                        cameraManager.setTorchMode(cameraId, true)
                        result.success(null)
                    } else {
                        result.error("UNAVAILABLE", "Flashlight not available", null)
                    }
                } catch (e: Exception) {
                    result.error("ERROR", "Failed to turn on flashlight", e.message)
                }
            }
            "flashlight_off" -> {
                try {
                    val cameraManager = context.getSystemService(Context.CAMERA_SERVICE) as CameraManager
                    val cameraId = cameraManager.cameraIdList.firstOrNull { id ->
                        cameraManager.getCameraCharacteristics(id).get(android.hardware.camera2.CameraCharacteristics.FLASH_INFO_AVAILABLE) == true
                    }
                    if (cameraId != null) {
                        cameraManager.setTorchMode(cameraId, false)
                        result.success(null)
                    } else {
                        result.error("UNAVAILABLE", "Flashlight not available", null)
                    }
                } catch (e: Exception) {
                    result.error("ERROR", "Failed to turn off flashlight", e.message)
                }
            }
            "media_play" -> dispatchMediaKey(KeyEvent.KEYCODE_MEDIA_PLAY, result)
            "media_pause" -> dispatchMediaKey(KeyEvent.KEYCODE_MEDIA_PAUSE, result)
            "media_next" -> dispatchMediaKey(KeyEvent.KEYCODE_MEDIA_NEXT, result)
            "media_prev" -> dispatchMediaKey(KeyEvent.KEYCODE_MEDIA_PREVIOUS, result)
            "volume_up" -> adjustVolume(AudioManager.ADJUST_RAISE, AudioManager.STREAM_MUSIC, result)
            "volume_down" -> adjustVolume(AudioManager.ADJUST_LOWER, AudioManager.STREAM_MUSIC, result)
            "volume_mute_media" -> adjustVolume(AudioManager.ADJUST_TOGGLE_MUTE, AudioManager.STREAM_MUSIC, result)
            "volume_mute_ring" -> adjustVolume(AudioManager.ADJUST_TOGGLE_MUTE, AudioManager.STREAM_RING, result)
            "vibrate_short" -> vibrate(50, result)
            "vibrate_long" -> vibrate(500, result)
            else -> result.notImplemented()
        }
    }

    private fun dispatchMediaKey(keyCode: Int, result: MethodChannel.Result) {
        try {
            val audioManager = context.getSystemService(Context.AUDIO_SERVICE) as AudioManager
            audioManager.dispatchMediaKeyEvent(KeyEvent(KeyEvent.ACTION_DOWN, keyCode))
            audioManager.dispatchMediaKeyEvent(KeyEvent(KeyEvent.ACTION_UP, keyCode))
            result.success(null)
        } catch (e: Exception) {
            result.error("ERROR", "Failed to dispatch media key", e.message)
        }
    }

    private fun adjustVolume(adjustment: Int, stream: Int, result: MethodChannel.Result) {
        try {
            val audioManager = context.getSystemService(Context.AUDIO_SERVICE) as AudioManager
            audioManager.adjustStreamVolume(stream, adjustment, AudioManager.FLAG_SHOW_UI)
            result.success(null)
        } catch (e: Exception) {
            result.error("ERROR", "Failed to adjust volume", e.message)
        }
    }

    private fun vibrate(durationMs: Long, result: MethodChannel.Result) {
        try {
            val vibrator = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                val vibratorManager = context.getSystemService(Context.VIBRATOR_MANAGER_SERVICE) as VibratorManager
                vibratorManager.defaultVibrator
            } else {
                @Suppress("DEPRECATION")
                context.getSystemService(Context.VIBRATOR_SERVICE) as Vibrator
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                vibrator.vibrate(VibrationEffect.createOneShot(durationMs, VibrationEffect.DEFAULT_AMPLITUDE))
            } else {
                @Suppress("DEPRECATION")
                vibrator.vibrate(durationMs)
            }
            result.success(null)
        } catch (e: Exception) {
            result.error("ERROR", "Failed to vibrate", e.message)
        }
    }
}
