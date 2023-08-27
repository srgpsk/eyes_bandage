import 'package:eyes_bandage/timer/timer.dart';

import 'settings.dart';

final class TimerManager {
  static final Formatter formatter = StringFormatter();

  static final Map<_TimerType, AppTimer> _timers = {};
  static AppTimer? _currentTimer;

  static void registerBreakTimer(
      {TimerCallback? onStart,
      TimerCallback? onComplete,
      TimerCallback? onTick}) {
    AppTimer timer = CountdownTimer(
        duration: Settings.breakDuration,
        onStart: onStart,
        onComplete: onComplete,
        onTick: onTick,
        formatter: formatter);

    _registerTimer(_TimerType.breakTimer, timer);
  }

  static void registerPauseTimer({TimerCallback? onStart, TimerCallback? onComplete}) {
    AppTimer timer = NormalTimer(
        duration: Settings.pauseDuration,
        onStart: onStart,
        onComplete: onComplete,
        formatter: formatter);

    _registerTimer(_TimerType.pauseTimer, timer);
  }

  static void registerPomodoroTimer(
      {TimerCallback? onStart, TimerCallback? onComplete}) {
    AppTimer timer = NormalTimer(
        duration: Settings.pomodoroDuration,
        onStart: onStart,
        onComplete: onComplete,
        formatter: formatter);

    _registerTimer(_TimerType.pomodoroTimer, timer);
  }

  static void startBreakTimer() {
    _runTimer(_TimerType.breakTimer);
  }

  static void startPauseTimer() {
    _runTimer(_TimerType.pauseTimer);
  }

  static void startPomodoroTimer() {
    _runTimer(_TimerType.pomodoroTimer);
  }

  static void cancelAllTimers() {
    for (var t in _timers.values) {
      t.cancel();
    }
  }

  static void _registerTimer(_TimerType type, AppTimer timer) {
    _timers[type] = timer;
  }

  static void _runTimer(_TimerType type) {
    _currentTimer?.cancel();
    _currentTimer = _timers[type];
    _currentTimer?.start();
  }
}

enum _TimerType {
  pomodoroTimer,
  breakTimer,
  pauseTimer,
}
