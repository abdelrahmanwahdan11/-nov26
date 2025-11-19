import 'package:audiobook_ebooks/data/dummy/dummy_data.dart';
import 'package:audiobook_ebooks/data/models/book.dart';
import 'package:flutter/material.dart';

class BooksController {
  final ValueNotifier<List<Book>> books = ValueNotifier([]);
  final ValueNotifier<bool> isLoading = ValueNotifier(true);
  final ValueNotifier<bool> isPaginating = ValueNotifier(false);
  int _page = 0;
  static const int _perPage = 10;

  void loadInitial() {
    isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 400), () {
      _page = 1;
      books.value = DummyData.books.take(_perPage).toList();
      isLoading.value = false;
    });
  }

  void paginate() {
    if (isPaginating.value) return;
    if (books.value.length >= DummyData.books.length) return;
    isPaginating.value = true;
    Future.delayed(const Duration(milliseconds: 400), () {
      _page += 1;
      final start = (_page - 1) * _perPage;
      final next = DummyData.books.skip(start).take(_perPage).toList();
      books.value = [...books.value, ...next];
      isPaginating.value = false;
    });
  }

  void refresh() {
    _page = 0;
    loadInitial();
  }

  void dispose() {
    books.dispose();
    isLoading.dispose();
    isPaginating.dispose();
  }
}
