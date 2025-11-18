import 'package:audiobook_ebooks/data/models/book.dart';
import 'package:flutter/material.dart';

class SearchController {
  final ValueNotifier<String> query = ValueNotifier('');
  final ValueNotifier<List<Book>> results = ValueNotifier([]);

  void updateQuery(String value, List<Book> source) {
    query.value = value;
    final lower = value.toLowerCase();
    results.value = source
        .where((book) =>
            book.title.toLowerCase().contains(lower) ||
            book.author.toLowerCase().contains(lower) ||
            book.genre.toLowerCase().contains(lower) ||
            book.description.toLowerCase().contains(lower))
        .toList();
  }
}
