import 'dart:ui';

abstract final class Settings {
  static const pomodoroDuration = Duration(minutes: 30);
  static const breakDuration = Duration(minutes: 5);
  static const pauseDuration = Duration(minutes: 2);
  static const buttonShowDuration = Duration(seconds: 3);

  static const mainTextColor = Color.fromRGBO(0, 0, 0, 1);
  static const overlayBackgroundColor = Color.fromRGBO(255, 255, 255, .4);
  static const buttonBackgroundColor = Color.fromRGBO(95, 158, 160, 1);
}
