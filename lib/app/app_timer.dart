import 'package:eyes_bandage/app/settings.dart';
import 'package:eyes_bandage/app/timer_manager.dart';
import 'package:eyes_bandage/app/window.dart';
import 'package:flutter/material.dart';

class AppTimer extends StatefulWidget {
  const AppTimer({super.key});

  @override
  State<AppTimer> createState() => _AppTimerState();
}

class _AppTimerState extends State<AppTimer> {
  late final Window _window;

  String _breakTime = '';

  @override
  Widget build(BuildContext context) {
    return Text(
      'Break ends in: $_breakTime',
      style: const TextStyle(
        fontSize: 32,
        color: Settings.mainTextColor,
      ),
    );
  }

  void _initWindow() {
    _window = Window(backgroundColor: Settings.overlayBackgroundColor);
  }

  @override
  void dispose() {
    TimerManager.cancelAllTimers();
    _window.destroy();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initWindow();
      _registerTimers();
      TimerManager.startPomodoroTimer();
    });
  }

  _registerTimers() {
    TimerManager.registerBreakTimer(
      onStart: (_) => _window.show(),
      onTick: (t) => setState(() => _breakTime = t.asString()),
      onComplete: (_) {
        _window.hide();
        TimerManager.startPomodoroTimer();
      },
    );

    TimerManager.registerPauseTimer(
      onStart: (_) => _window.hide(),
      onComplete: (_) {
        TimerManager.startBreakTimer();
      },
    );

    TimerManager.registerPomodoroTimer(
      onStart: (_) => _window.hide(),
      onComplete: (_) => TimerManager.startBreakTimer(),
    );
  }
}
