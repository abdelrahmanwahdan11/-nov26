import 'package:audiobook_ebooks/data/models/achievement.dart';
import 'package:audiobook_ebooks/data/models/app_notification.dart';
import 'package:audiobook_ebooks/data/models/book.dart';
import 'package:audiobook_ebooks/data/models/chapter.dart';
import 'package:audiobook_ebooks/data/models/download_item.dart';
import 'package:audiobook_ebooks/data/models/reading_stat.dart';
import 'package:audiobook_ebooks/data/models/review.dart';

class DummyData {
  static final List<Book> books = List.generate(
    20,
    (index) => Book(
      id: 'book-$index',
      title: 'Fictional Odyssey $index',
      author: 'Author $index',
      genre: index % 3 == 0
          ? 'Fiction'
          : index % 3 == 1
              ? 'History'
              : 'Young Adult',
      coverUrl: 'https://picsum.photos/seed/book$index/400/600',
      description:
          'A captivating journey across worlds with adventure and emotion. Book number $index comes with immersive narration.',
      rating: 4 + (index % 2) * 0.5,
      likes: 1500 + index * 120,
      durationMinutes: 45 + index * 10,
      isLocked: index % 3 == 0,
      isPopular: index % 2 == 0,
      language: index % 2 == 0 ? 'EN' : 'AR',
    ),
  );

  static List<Chapter> chaptersFor(String bookId) {
    return List.generate(
      6,
      (i) => Chapter(
        id: '$bookId-chapter-$i',
        bookId: bookId,
        title: 'Chapter ${i + 1}',
        order: i + 1,
        durationMinutes: 8 + i * 2,
        isLocked: i % 3 == 0,
      ),
    );
  }

  static List<Review> reviewsFor(String bookId) {
    return List.generate(
      4,
      (i) => Review(
        id: '$bookId-review-$i',
        bookId: bookId,
        userName: 'Listener $i',
        userAvatarUrl: 'https://picsum.photos/seed/user$i/80/80',
        rating: 3.5 + (i % 2) * 0.5,
        date: DateTime.now().subtract(Duration(days: i * 5)),
        verified: i % 2 == 0,
        content:
            'Engaging storytelling with clear narration. Review $i praises the pacing and character depth.',
      ),
    );
  }

  static const achievements = [
    Achievement(
      id: 'streak',
      title: '7-Day Streak',
      description: 'Listened or read something every day for a week.',
      progress: 5,
      target: 7,
      badgeUrl: 'https://picsum.photos/seed/badge1/120/120',
      completed: false,
    ),
    Achievement(
      id: 'listener',
      title: 'Dedicated Listener',
      description: 'Completed 5 audiobooks this month.',
      progress: 4,
      target: 5,
      badgeUrl: 'https://picsum.photos/seed/badge2/120/120',
      completed: false,
    ),
    Achievement(
      id: 'critic',
      title: 'Top Reviewer',
      description: 'Published 10 thoughtful reviews.',
      progress: 10,
      target: 10,
      badgeUrl: 'https://picsum.photos/seed/badge3/120/120',
      completed: true,
    ),
  ];

  static final notifications = [
    AppNotification(
      id: 'n1',
      title: 'New chapter unlocked',
      body: 'Chapter 3 of Fictional Odyssey just dropped for you to enjoy.',
      date: DateTime.now().subtract(const Duration(hours: 2)),
      isNew: true,
    ),
    AppNotification(
      id: 'n2',
      title: 'Weekly digest',
      body: 'You spent 3h 20m listening last week. Keep the streak going!',
      date: DateTime.now().subtract(const Duration(days: 1)),
      isNew: false,
    ),
    AppNotification(
      id: 'n3',
      title: 'Goal reminder',
      body: 'Only 10 minutes left to reach today\'s focus goal.',
      date: DateTime.now().subtract(const Duration(days: 3)),
      isNew: false,
    ),
  ];

  static const downloads = [
    DownloadItem(
      id: 'd1',
      title: 'Offline Odyssey',
      coverUrl: 'https://picsum.photos/seed/download1/200/200',
      progress: 80,
      completed: false,
    ),
    DownloadItem(
      id: 'd2',
      title: 'Quiet History',
      coverUrl: 'https://picsum.photos/seed/download2/200/200',
      progress: 100,
      completed: true,
    ),
  ];

  static const readingStats = [
    ReadingStat(label: 'Weekly time', value: '3h 20m', progress: 0.65),
    ReadingStat(label: 'Chapters finished', value: '18', progress: 0.72),
    ReadingStat(label: 'Focus goal', value: '80%', progress: 0.8),
  ];
}
