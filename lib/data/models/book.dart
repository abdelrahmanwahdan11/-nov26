import 'package:flutter/material.dart';

@immutable
class Book {
  final String id;
  final String title;
  final String author;
  final String genre;
  final String coverUrl;
  final String description;
  final double rating;
  final int likes;
  final int durationMinutes;
  final bool isLocked;
  final bool isPopular;
  final String language;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.coverUrl,
    required this.description,
    required this.rating,
    required this.likes,
    required this.durationMinutes,
    required this.isLocked,
    required this.isPopular,
    required this.language,
  });
}
