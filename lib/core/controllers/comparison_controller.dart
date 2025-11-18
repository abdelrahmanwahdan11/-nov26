import 'package:audiobook_ebooks/data/models/book.dart';
import 'package:flutter/material.dart';

class ComparisonController {
  final ValueNotifier<List<Book>> selected = ValueNotifier([]);

  void toggle(Book book) {
    final current = [...selected.value];
    if (current.any((b) => b.id == book.id)) {
      current.removeWhere((b) => b.id == book.id);
    } else if (current.length < 3) {
      current.add(book);
    }
    selected.value = current;
  }

  bool isSelected(Book book) =>
      selected.value.any((element) => element.id == book.id);
}
