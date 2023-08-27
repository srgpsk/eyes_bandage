import 'dart:ui';

import 'package:window_manager/window_manager.dart';

class Window {
  final Color backgroundColor;

  Window({required this.backgroundColor}) {
    _init();
  }

  // void closeWindow() async {
  //   await windowManager.close();
  // }

  void hide() async {
    await windowManager.hide();
  }

  void show() async {
    await windowManager.show();
    // await windowManager.focus();
  }
  
  void destroy() {
    windowManager.destroy();
  }

  void _init() async {
    // Must add this line.
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = WindowOptions(
      fullScreen: true,
      center: true,
      backgroundColor: backgroundColor,
      skipTaskbar: false,
      titleBarStyle: TitleBarStyle.hidden,
    );

    windowManager.waitUntilReadyToShow(windowOptions);
  }
}
