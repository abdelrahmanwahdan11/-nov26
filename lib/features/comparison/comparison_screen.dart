import 'package:audiobook_ebooks/core/controllers/comparison_controller.dart';
import 'package:audiobook_ebooks/data/models/book.dart';
import 'package:flutter/material.dart';

class ComparisonScreen extends StatelessWidget {
  const ComparisonScreen({super.key, required this.comparisonController});
  final ComparisonController comparisonController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compare Books')),
      body: ValueListenableBuilder(
        valueListenable: comparisonController.selected,
        builder: (context, list, _) {
          return Column(
            children: [
              SizedBox(
                height: 140,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(12),
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final book = list[index];
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(book.coverUrl),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => comparisonController.toggle(book),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                child: _ComparisonTable(books: list),
              )
            ],
          );
        },
      ),
    );
  }
}

class _ComparisonTable extends StatelessWidget {
  const _ComparisonTable({required this.books});
  final List<Book> books;

  @override
  Widget build(BuildContext context) {
    final rows = [
      _MetricRow(label: 'Rating', values: books.map((b) => '${b.rating} ★').toList()),
      _MetricRow(label: 'Duration', values: books.map((b) => '${b.durationMinutes}m').toList()),
      _MetricRow(label: 'Genre', values: books.map((b) => b.genre).toList()),
      _MetricRow(label: 'Language', values: books.map((b) => b.language).toList()),
      _MetricRow(label: 'Popularity', values: books.map((b) => b.likes.toString()).toList()),
    ];
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: rows,
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.label, required this.values});
  final String label;
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            SizedBox(
              width: 100,
              child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            ...values.map(
              (v) => Expanded(
                child: Center(child: Text(v)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
