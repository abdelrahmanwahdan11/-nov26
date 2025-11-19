import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:audiobook_ebooks/data/dummy/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DownloadsCenterScreen extends StatelessWidget {
  const DownloadsCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final downloads = DummyData.downloads;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.translate('downloadsCenter'))),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final item = downloads[index];
          final progress = item.progress;
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(item.coverUrl, width: 60, height: 60, fit: BoxFit.cover),
              ),
              title: Text(item.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${item.sizeMb.toStringAsFixed(1)} MB · ${item.status}'),
                  const SizedBox(height: 6),
                  LinearProgressIndicator(value: progress).animate().shimmer(duration: 800.ms),
                ],
              ),
              trailing: Icon(
                item.status == 'completed' ? Icons.check_circle : Icons.downloading,
                color: item.status == 'completed'
                    ? Colors.green
                    : theme.colorScheme.primary,
              ),
            ),
          ).animate().fadeIn(duration: 240.ms).slide(begin: const Offset(0, 0.05));
        },
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: downloads.length,
      ),
    );
  }
}
