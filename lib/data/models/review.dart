import 'package:flutter/material.dart';

@immutable
class Review {
  final String id;
  final String bookId;
  final String userName;
  final String userAvatarUrl;
  final double rating;
  final DateTime date;
  final bool verified;
  final String content;

  const Review({
    required this.id,
    required this.bookId,
    required this.userName,
    required this.userAvatarUrl,
    required this.rating,
    required this.date,
    required this.verified,
    required this.content,
  });
}
