import 'package:audiobook_ebooks/core/localization/app_localizations.dart';
import 'package:flutter/material.dart';

class AiInfoButton extends StatelessWidget {
  const AiInfoButton({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return IconButton(
      icon: const Icon(Icons.auto_awesome),
      tooltip: loc.translate('aiSoon'),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(loc.translate('aiSoon'))),
        );
      },
    );
  }
}
