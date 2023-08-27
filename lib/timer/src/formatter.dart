abstract interface class Formatter {
  dynamic format(Duration duration);
}

final class StringFormatter implements Formatter {
  @override
  String format(Duration duration) {
    int timeInSeconds = duration.inSeconds;
    String minutes = _formatNum(timeInSeconds ~/ 60);
    String seconds = _formatNum(timeInSeconds % 60);
    return '$minutes:$seconds';
  }

  String _formatNum(int num) {
    return num.toString().padLeft(2, '0');
  }
}
