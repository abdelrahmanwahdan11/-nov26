import 'dart:async';

import 'package:flutter/material.dart';

class PlayerController {
  final ValueNotifier<bool> isPlaying = ValueNotifier(false);
  final ValueNotifier<Duration> position = ValueNotifier(Duration.zero);
  final ValueNotifier<Duration> total =
      ValueNotifier(const Duration(minutes: 5, seconds: 30));
  Timer? _timer;

  void togglePlay() {
    if (isPlaying.value) {
      pause();
    } else {
      play();
    }
  }

  void play() {
    isPlaying.value = true;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final next = position.value + const Duration(seconds: 1);
      if (next >= total.value) {
        stop();
      } else {
        position.value = next;
      }
    });
  }

  void pause() {
    isPlaying.value = false;
    _timer?.cancel();
  }

  void stop() {
    _timer?.cancel();
    isPlaying.value = false;
    position.value = Duration.zero;
  }

  void dispose() {
    _timer?.cancel();
    isPlaying.dispose();
    position.dispose();
    total.dispose();
  }
}
