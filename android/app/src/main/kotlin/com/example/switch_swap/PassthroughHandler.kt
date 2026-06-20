package com.example.switch_swap

import android.content.Context
import android.media.AudioManager
import android.util.Log
import android.view.KeyEvent
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class PassthroughHandler(private val context: Context) {
    fun handle(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "passthrough_keys") {
            try {
                val keyCodes = call.argument<List<Int>>("keyCodes") ?: listOf()
                Log.i("SwitchSwap-Brain", "5. KOTLIN RECEIVED PASSTHROUGH - Array size: ${keyCodes.size}")
                
                val audioManager = context.getSystemService(Context.AUDIO_SERVICE) as AudioManager
                
                for (keyCode in keyCodes) {
                    Log.i("SwitchSwap-Brain", "6. EXECUTING SYSTEM VOLUME CHANGE - KeyCode: $keyCode")
                    
                    if (keyCode == KeyEvent.KEYCODE_VOLUME_UP) {
                        audioManager.adjustStreamVolume(AudioManager.STREAM_MUSIC, AudioManager.ADJUST_RAISE, AudioManager.FLAG_SHOW_UI)
                    } else if (keyCode == KeyEvent.KEYCODE_VOLUME_DOWN) {
                        audioManager.adjustStreamVolume(AudioManager.STREAM_MUSIC, AudioManager.ADJUST_LOWER, AudioManager.FLAG_SHOW_UI)
                    } else if (keyCode == KeyEvent.KEYCODE_HEADSETHOOK || keyCode == KeyEvent.KEYCODE_MEDIA_PLAY_PAUSE) {
                        audioManager.dispatchMediaKeyEvent(KeyEvent(KeyEvent.ACTION_DOWN, keyCode))
                        audioManager.dispatchMediaKeyEvent(KeyEvent(KeyEvent.ACTION_UP, keyCode))
                    }
                }
                
                result.success(null)
            } catch (e: Exception) {
                result.error("ERROR", "Failed to passthrough keys", e.message)
            }
        } else {
            result.notImplemented()
        }
    }
}
