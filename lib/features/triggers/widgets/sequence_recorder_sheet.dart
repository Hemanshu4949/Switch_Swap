import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/ui_key_capture_service.dart';
import '../../../core/engine/permission_service.dart';
import '../../home/providers/permission_provider.dart';

enum InputSource { keyboard, phone, gamepad, headset }

class SequenceRecorderSheet extends ConsumerStatefulWidget {
  final InputSource source;

  const SequenceRecorderSheet({super.key, required this.source});

  static Future<List<String>?> show(BuildContext context, InputSource source) {
    return showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SequenceRecorderSheet(source: source),
    );
  }

  @override
  ConsumerState<SequenceRecorderSheet> createState() => _SequenceRecorderSheetState();
}

class _SequenceRecorderSheetState extends ConsumerState<SequenceRecorderSheet> with SingleTickerProviderStateMixin {
  bool _isRecording = false;
  final List<String> _currentSequence = [];
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    UIKeyCaptureService().stopCapture();
    _pulseController.dispose();
    super.dispose();
  }

  String _translateKey(dynamic key) {
    if (key == 24 || key == LogicalKeyboardKey.audioVolumeUp) return "Volume Up";
    if (key == 25 || key == LogicalKeyboardKey.audioVolumeDown) return "Volume Down";
    if (key == 85) return "Media Play/Pause";
    if (key == 79) return "Headset Hook";
    
    if (key is LogicalKeyboardKey) return key.keyLabel;
    
    return "Key $key";
  }

  void _stopRecording() {
    _isRecording = false;
    _pulseController.stop();
    _pulseController.value = 1.0;
    UIKeyCaptureService().stopCapture();
  }

  void _toggleRecording() {
    setState(() {
      if (_isRecording) {
        _stopRecording();
      } else {
        _isRecording = true;
        _pulseController.repeat(reverse: true);
        
        UIKeyCaptureService().startCapture(
          isAccessibilityEnabled: ref.read(accessibilityPermissionProvider),
          isPhoneSource: widget.source == InputSource.phone,
          callback: (capturedKey) {
            if (!mounted) return;
            setState(() {
              _currentSequence.add(_translateKey(capturedKey));
              
              if (_currentSequence.length >= 10) {
                 _stopRecording();
                 ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(
                     content: const Text("Maximum sequence limit of 10 keys reached.", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                     backgroundColor: Theme.of(context).colorScheme.error,
                     behavior: SnackBarBehavior.floating,
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                     margin: const EdgeInsets.all(16),
                   )
                 );
              }
            });
          }
        );
      }
    });
  }

  String get _sourceName {
    switch (widget.source) {
      case InputSource.keyboard: return "Keyboard Studio";
      case InputSource.phone: return "Phone Studio";
      case InputSource.gamepad: return "Gamepad Studio";
      case InputSource.headset: return "Headset Studio";
    }
  }

  IconData _getIconForAction(String action) {
    final lowerAction = action.toLowerCase();
    if (lowerAction.contains('volume up')) return Icons.volume_up;
    if (lowerAction.contains('volume down')) return Icons.volume_down;
    if (lowerAction.contains('media') || lowerAction.contains('play') || lowerAction.contains('pause')) return Icons.play_arrow;
    if (lowerAction.contains('headset')) return Icons.headset;
    return Icons.keyboard; // Default icon
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final isAccessibilityEnabled = ref.watch(accessibilityPermissionProvider);
    final isBlocked = (widget.source == InputSource.headset || widget.source == InputSource.gamepad) && !isAccessibilityEnabled;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          Center(
            child: Text(
              _sourceName.toUpperCase(),
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
                letterSpacing: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              "Real-Time Sequence Visualizer",
              style: textTheme.bodyMedium?.copyWith(color: colorScheme.onSurfaceVariant),
            ),
          ),
          const SizedBox(height: 32),

          // Visualizer Area
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: _isRecording ? colorScheme.primary.withValues(alpha: 0.5) : Colors.transparent, width: 2),
              ),
              child: _currentSequence.isEmpty
                  ? Center(
                      child: _isRecording
                          ? AnimatedBuilder(
                              animation: _pulseAnimation,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _pulseAnimation.value,
                                  child: Opacity(
                                    opacity: (_pulseAnimation.value - 0.2).clamp(0.0, 1.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.sensors, size: 48, color: colorScheme.primary),
                                        const SizedBox(height: 16),
                                        Text(
                                          "Listening for hardware keys...",
                                          style: textTheme.titleMedium?.copyWith(color: colorScheme.primary),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : Text(
                              "Tap record to start capturing.",
                              style: textTheme.titleMedium?.copyWith(color: colorScheme.onSurfaceVariant),
                            ),
                    )
                  : SingleChildScrollView(
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        alignment: WrapAlignment.center,
                        children: _currentSequence.map((key) {
                          return Chip(
                            avatar: Icon(
                              _getIconForAction(key),
                              color: colorScheme.onPrimary,
                              size: 18,
                            ),
                            label: Text(
                              key,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onPrimary,
                              ),
                            ),
                            backgroundColor: colorScheme.primary,
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          );
                        }).toList(),
                      ),
                    ),
            ),
          ),

          const SizedBox(height: 24),

          // Phone Device Buttons (Mock Hardware)
          if (widget.source == InputSource.phone) ...[
            _buildPhoneButtonGrid(colorScheme),
            const SizedBox(height: 24),
          ],

          // Control Buttons Area
          if (isBlocked)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.source == InputSource.headset ? Icons.headset_off : Icons.videogame_asset_off, size: 48, color: colorScheme.error),
                const SizedBox(height: 16),
                Text(
                  "Accessibility Service is required to intercept ${widget.source == InputSource.headset ? 'Headset' : 'Gamepad'} buttons.",
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => PermissionService.openAccessibilitySettings(),
                  icon: const Icon(Icons.settings),
                  label: const Text("Enable in Settings"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            )
          else ...[
            Center(
              child: FloatingActionButton.extended(
                onPressed: _toggleRecording,
                backgroundColor: _isRecording ? colorScheme.error : colorScheme.primary,
                foregroundColor: _isRecording ? colorScheme.onError : colorScheme.onPrimary,
                icon: Icon(_isRecording ? Icons.stop : Icons.fiber_manual_record),
                label: Text(
                  _isRecording ? "Stop Recording" : "Record Sequence",
                  style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _currentSequence.clear();
                      if (_isRecording) {
                        _stopRecording();
                      }
                    });
                  },
                  icon: const Icon(Icons.clear_all),
                  label: const Text("Clear"),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
                FilledButton.icon(
                  onPressed: _currentSequence.isEmpty ? null : () {
                    if (_isRecording) {
                      _stopRecording();
                    }
                    Navigator.of(context).pop(_currentSequence);
                  },
                  icon: const Icon(Icons.save),
                  label: const Text("Save Sequence"),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPhoneButtonGrid(ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDeviceButton(
          label: "Volume Down",
          icon: Icons.volume_down,
          colorScheme: colorScheme,
        ),
        const SizedBox(width: 24),
        _buildDeviceButton(
          label: "Volume Up",
          icon: Icons.volume_up,
          colorScheme: colorScheme,
        ),
      ],
    );
  }

  Widget _buildDeviceButton({
    required String label,
    required IconData icon,
    required ColorScheme colorScheme,
  }) {
    return Opacity(
      opacity: _isRecording ? 1.0 : 0.4,
      child: InkWell(
        onTap: _isRecording
            ? () {
                setState(() {
                  _currentSequence.add(label);
                  if (_currentSequence.length >= 10) {
                     _stopRecording(); 
                     ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(
                         content: const Text("Maximum sequence limit of 10 keys reached.", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                         backgroundColor: Theme.of(context).colorScheme.error,
                         behavior: SnackBarBehavior.floating,
                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                         margin: const EdgeInsets.all(16),
                       )
                     );
                  }
                });
              }
            : null,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: colorScheme.onSurfaceVariant),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
