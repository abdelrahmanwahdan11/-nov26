import 'package:audiobook_ebooks/core/controllers/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key, required this.title});
  final String title;

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final PlayerController _controller = PlayerController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.network(
                        'https://picsum.photos/seed/player/400/400',
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(widget.title,
                        style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ValueListenableBuilder(
              valueListenable: _controller.position,
              builder: (context, pos, _) {
                return Column(
                  children: [
                    Slider(
                      value: pos.inSeconds.toDouble(),
                      max: _controller.total.value.inSeconds.toDouble(),
                      onChanged: (value) {},
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_format(pos)),
                        Text(_format(_controller.total.value - pos)),
                      ],
                    )
                  ],
                );
              },
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.skip_previous_rounded, size: 36),
                ),
                const SizedBox(width: 12),
                ValueListenableBuilder(
                  valueListenable: _controller.isPlaying,
                  builder: (context, playing, _) {
                    return FloatingActionButton.large(
                      onPressed: _controller.togglePlay,
                      child: Icon(
                        playing ? Icons.pause : Icons.play_arrow,
                        size: 38,
                      ),
                    ).animate().scale();
                  },
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.skip_next_rounded, size: 36),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Most Popular',
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: 4,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.play_arrow),
                    title: Text('Episode ${index + 1}'),
                    subtitle: const Text('5 min'),
                    onTap: _controller.play,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  String _format(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
