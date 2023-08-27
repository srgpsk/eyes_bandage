import 'package:eyes_bandage/app/timer_manager.dart';
import 'package:flutter/material.dart';

import 'app_timer.dart';
import 'settings.dart';

class App extends StatelessWidget {
  late final ElevatedButton _pauseButton;

  late final ElevatedButton _skipButton;

  late final Future<String> _buttonShowDelay;

  App({super.key}) {
    _initProps();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const AppTimer(),
            FutureBuilder<String>(
                future: _buttonShowDelay,
                // a previously-obtained Future<String> or null
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  List<Widget> children;
                  children = <Widget>[];
                  if (snapshot.hasData) {
                    children = <Widget>[
                      _pauseButton,
                      const SizedBox(
                        width: 150.0,
                      ),
                      _skipButton,
                    ];
                  }

                  return Padding(
                    padding: const EdgeInsets.only(top: 32.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: children),
                  );
                }),
          ],
        ));
  }

  void _initProps() {
    _pauseButton = _makeButton(
        text: 'Pause', onPressed: () => TimerManager.startPauseTimer());
    _skipButton = _makeButton(
        text: 'Skip', onPressed: () => TimerManager.startPomodoroTimer());
    _buttonShowDelay = Future.delayed(Settings.buttonShowDuration, () => '');
  }

  ElevatedButton _makeButton({required String text, VoidCallback? onPressed}) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 22),
      padding: const EdgeInsets.all(20.0),
      backgroundColor: Settings.buttonBackgroundColor,
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Text(text),
      ),
    );
  }
}
