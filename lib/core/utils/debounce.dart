import 'dart:async';

class Debounce {
  final Duration delay;
  Timer? _timer;

  Debounce({required this.delay});

  void call(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }
}
