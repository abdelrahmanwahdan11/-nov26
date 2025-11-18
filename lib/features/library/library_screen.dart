import 'package:audiobook_ebooks/core/constants/app_constants.dart';
import 'package:audiobook_ebooks/core/controllers/books_controller.dart';
import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key, required this.booksController});
  final BooksController booksController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Library')),
      body: ValueListenableBuilder(
        valueListenable: booksController.books,
        builder: (context, books, _) {
          return RefreshIndicator(
            onRefresh: () async => booksController.refresh(),
            child: ListView.separated(
              padding: const EdgeInsets.all(AppConstants.padding),
              itemCount: books.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final b = books[index];
                return Card(
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child:
                          Image.network(b.coverUrl, width: 56, height: 56, fit: BoxFit.cover),
                    ),
                    title: Text(b.title),
                    subtitle: const LinearProgressIndicator(value: .4),
                    trailing: IconButton(
                      icon: const Icon(Icons.play_arrow),
                      onPressed: () {},
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
