import 'dart:async' show Timer;

import 'formatter.dart';

typedef TimerCallback = Function(AppTimer t);

abstract interface class AppTimer {
  String asString();

  void cancel();

  void start();

  void _init();
}

abstract base class BaseTimer implements AppTimer {
  final Duration duration;
  final TimerCallback? onStart;
  final TimerCallback? onComplete;
  final Formatter? formatter;

  Timer? _timer;

  BaseTimer(
      {required this.duration, this.onStart, this.onComplete, this.formatter});

  @override
  void cancel() {
   _timer?.cancel();
  }

  @override
  void start() {
    _reset(); // clean running state if any
    _init();

    if (onStart != null) onStart!(this);
  }

  void _complete() {
    // _timer?.cancel();

    if (onComplete != null) onComplete!(this);

    _timer = null;
  }

  void _reset() {
    _timer?.cancel();
    _timer = null;
  }
}

/// To avoid dealing with negative time, ensures: duration % tickDuration == 0
final class CountdownTimer extends BaseTimer {
  final Duration tickDuration;
  final TimerCallback? onTick;

  CountdownTimer({
    required super.duration,
    super.onStart,
    super.onComplete,
    super.formatter,
    this.tickDuration = const Duration(seconds: 1),
    this.onTick,
  }) : assert(duration.inSeconds % tickDuration.inSeconds == 0);

  int get _elapsedTicks {
    return _timer?.tick ?? 0;
  }

  Duration get _timeLeft {
    return duration - tickDuration * _elapsedTicks;
  }

  @override
  String asString() {
    return formatter?.format(_timeLeft) ?? _timeLeft.inSeconds.toString();
  }

  @override
  String toString() {
    return asString();
  }

  @override
  void _init() {
    _timer = Timer.periodic(tickDuration, _tick);
  }

  void _tick(_) {
    if (onTick != null) onTick!(this);

    if (_timeLeft == Duration.zero) {
      _complete();
    }
  }
}

/// Only one timer in runtime
final class NormalTimer extends BaseTimer {
  NormalTimer(
      {required super.duration,
      super.onStart,
      super.onComplete,
      super.formatter});

  @override
  String asString() {
    return formatter?.format(duration);
  }

  @override
  String toString() {
    return asString();
  }

  @override
  void _init() {
    _timer = Timer(duration, _complete);
  }
}
