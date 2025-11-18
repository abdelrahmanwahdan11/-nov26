import 'package:flutter/material.dart';

@immutable
class Chapter {
  final String id;
  final String bookId;
  final String title;
  final int order;
  final int durationMinutes;
  final bool isLocked;

  const Chapter({
    required this.id,
    required this.bookId,
    required this.title,
    required this.order,
    required this.durationMinutes,
    required this.isLocked,
  });
}
