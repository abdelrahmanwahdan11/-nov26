import 'package:audiobook_ebooks/core/controllers/search_controller.dart';
import 'package:audiobook_ebooks/data/models/book.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.books});
  final List<Book> books;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchController _controller = SearchController();
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _textController,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Search...'),
          onChanged: (value) => _controller.updateQuery(value, widget.books),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: _controller.results,
        builder: (context, results, _) {
          if (_textController.text.isEmpty) {
            return const Center(child: Text('Type to search'));
          }
          if (results.isEmpty) {
            return const Center(child: Text('No results found'));
          }
          return ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final book = results[index];
              return ListTile(
                leading: Image.network(book.coverUrl, width: 48, height: 48, fit: BoxFit.cover),
                title: Text(book.title),
                subtitle: Text(book.author),
              );
            },
          );
        },
      ),
    );
  }
}
