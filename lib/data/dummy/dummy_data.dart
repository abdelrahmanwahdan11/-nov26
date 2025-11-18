import 'package:audiobook_ebooks/data/models/achievement.dart';
import 'package:audiobook_ebooks/data/models/app_notification.dart';
import 'package:audiobook_ebooks/data/models/author_spotlight.dart';
import 'package:audiobook_ebooks/data/models/book.dart';
import 'package:audiobook_ebooks/data/models/chapter.dart';
import 'package:audiobook_ebooks/data/models/curated_collection.dart';
import 'package:audiobook_ebooks/data/models/download_item.dart';
import 'package:audiobook_ebooks/data/models/daily_brief.dart';
import 'package:audiobook_ebooks/data/models/immersion_mix.dart';
import 'package:audiobook_ebooks/data/models/journey_event.dart';
import 'package:audiobook_ebooks/data/models/listening_club.dart';
import 'package:audiobook_ebooks/data/models/live_session.dart';
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

  static const curatedCollections = [
    CuratedCollection(
      id: 'mindful',
      title: 'Mindful Mornings',
      subtitle: 'Slow-burn stories to ease you into the day.',
      coverUrl: 'https://picsum.photos/seed/collection1/800/600',
      tags: ['Calm', 'Inspiring', 'Soft voices'],
    ),
    CuratedCollection(
      id: 'night',
      title: 'Nightfall Narratives',
      subtitle: 'Cozy listens to drift off with.',
      coverUrl: 'https://picsum.photos/seed/collection2/800/600',
      tags: ['Sleep', 'Ambient', 'Short form'],
    ),
    CuratedCollection(
      id: 'deep',
      title: 'Deep Focus',
      subtitle: 'Instrumental and low-dialogue picks.',
      coverUrl: 'https://picsum.photos/seed/collection3/800/600',
      tags: ['Productivity', 'Minimal', 'Loopable'],
    ),
  ];

  static const journey = [
    JourneyEvent(
      id: 'morning-focus',
      title: 'Morning Focus',
      description: 'Finished a 20-minute focus block with Deep Focus mix.',
      dateLabel: 'Today',
      emphasis: 0.9,
    ),
    JourneyEvent(
      id: 'shared-note',
      title: 'Shared note',
      description: 'Left a highlight on Fictional Odyssey chapter 3.',
      dateLabel: 'Yesterday',
      emphasis: 0.7,
    ),
    JourneyEvent(
      id: 'week-streak',
      title: '1-week streak',
      description: 'Kept your 7-day streak alive with nightly listens.',
      dateLabel: 'This week',
      emphasis: 1,
    ),
    JourneyEvent(
      id: 'new-genre',
      title: 'New genre explored',
      description: 'Tried two new Young Adult titles and loved one.',
      dateLabel: 'Last week',
      emphasis: 0.5,
    ),
  ];

  static const authorSpotlights = [
    AuthorSpotlight(
      id: 'solana-reef',
      name: 'Solana Reef',
      tagline: 'Cozy sci-fi storyteller',
      bio:
          'Known for atmospheric worlds and whisper-soft narration, Solana mixes warmth with wonder.',
      coverUrl: 'https://picsum.photos/seed/author1/900/600',
      booksCount: 12,
      highlights: [
        'Breathes life into quiet characters',
        'Award-winning "Silent Orbits" trilogy',
        'Fan-favorite lullaby outros',
      ],
    ),
    AuthorSpotlight(
      id: 'amir-habib',
      name: 'Amir Habib',
      tagline: 'History with heart',
      bio:
          'Amir blends real events with intimate storytelling that keeps night listeners hooked.',
      coverUrl: 'https://picsum.photos/seed/author2/900/600',
      booksCount: 18,
      highlights: [
        'Narrates in both AR/EN with ease',
        'Curates immersive soundscapes',
        'Beloved for concise chapter recaps',
      ],
    ),
    AuthorSpotlight(
      id: 'lina-qureshi',
      name: 'Lina Qureshi',
      tagline: 'Mindful essays & poetry',
      bio:
          'Lina delivers reflective micro-essays perfect for calm morning routines and focus sprints.',
      coverUrl: 'https://picsum.photos/seed/author3/900/600',
      booksCount: 9,
      highlights: [
        'Creates bilingual companion notes',
        'Chill, minimalist pacing',
        'Popular "Breathe Deeper" series',
      ],
    ),
  ];

  static const listeningClubs = [
    ListeningClub(
      id: 'quiet-club',
      title: 'Quiet Night Club',
      host: 'Lina Qureshi',
      timeLabel: 'Today · 9:00 PM',
      members: 264,
      coverUrl: 'https://picsum.photos/seed/club1/900/600',
      mood: 'Calm focus',
    ),
    ListeningClub(
      id: 'history-lounge',
      title: 'History Lounge',
      host: 'Amir Habib',
      timeLabel: 'Tomorrow · 7:30 PM',
      members: 412,
      coverUrl: 'https://picsum.photos/seed/club2/900/600',
      mood: 'Story circle',
    ),
    ListeningClub(
      id: 'sunrise-readers',
      title: 'Sunrise Readers',
      host: 'Solana Reef',
      timeLabel: 'Saturday · 8:00 AM',
      members: 188,
      coverUrl: 'https://picsum.photos/seed/club3/900/600',
      mood: 'Soft mornings',
    ),
  ];

  static const immersions = [
    ImmersionMix(
      id: 'breathe',
      title: 'Breathe & Begin',
      subtitle: '5-minute slow entry with hush vocals.',
      mood: 'Calm',
      minutes: 5,
      coverUrl: 'https://picsum.photos/seed/immersion1/900/600',
      tags: ['Breath', 'Soothing', 'Warm light'],
    ),
    ImmersionMix(
      id: 'deep-work',
      title: 'Deep Work Pulse',
      subtitle: 'Gentle pulses that sync to your focus goal.',
      mood: 'Focus',
      minutes: 18,
      coverUrl: 'https://picsum.photos/seed/immersion2/900/600',
      tags: ['Minimal', 'Looped', 'No vocals'],
    ),
    ImmersionMix(
      id: 'night-chill',
      title: 'Night Chill Drift',
      subtitle: 'Low-tone hums and distant rainfall.',
      mood: 'Sleep',
      minutes: 12,
      coverUrl: 'https://picsum.photos/seed/immersion3/900/600',
      tags: ['Rain', 'Cozy', 'Dim'],
    ),
    ImmersionMix(
      id: 'micro-story',
      title: 'Micro Story Sparks',
      subtitle: 'Three 90-second hooks to pick your next book.',
      mood: 'Discover',
      minutes: 6,
      coverUrl: 'https://picsum.photos/seed/immersion4/900/600',
      tags: ['Snappy', 'Narrated', 'Try-outs'],
    ),
  ];

  static const liveSessions = [
    LiveSession(
      id: 'sunrise-flow',
      title: 'Sunrise Flow',
      host: 'Lina Qureshi',
      timeLabel: 'Today · 6:45 AM',
      mood: 'Calm focus',
      lengthLabel: '25m',
      coverUrl: 'https://picsum.photos/seed/session1/900/600',
    ),
    LiveSession(
      id: 'midday-burst',
      title: 'Midday Burst',
      host: 'Amir Habib',
      timeLabel: 'Today · 12:10 PM',
      mood: 'Energy',
      lengthLabel: '18m',
      coverUrl: 'https://picsum.photos/seed/session2/900/600',
    ),
    LiveSession(
      id: 'night-reset',
      title: 'Night Reset',
      host: 'Solana Reef',
      timeLabel: 'Tonight · 9:15 PM',
      mood: 'Sleep wind-down',
      lengthLabel: '30m',
      coverUrl: 'https://picsum.photos/seed/session3/900/600',
    ),
  ];

  static const dailyBriefs = [
    DailyBrief(
      id: 'pulse',
      headline: 'Pulse through the morning',
      subtitle: 'Stack 12 minutes of audio sprints for a sharper focus arc.',
      coverUrl: 'https://picsum.photos/seed/brief1/900/600',
      durationLabel: '12m micro',
      mood: 'Focus',
    ),
    DailyBrief(
      id: 'soothe',
      headline: 'Soothe + Stretch',
      subtitle: 'Pair calm narration with light stretching cues.',
      coverUrl: 'https://picsum.photos/seed/brief2/900/600',
      durationLabel: '15m calm',
      mood: 'Calm',
    ),
    DailyBrief(
      id: 'discover',
      headline: 'Discover a new voice',
      subtitle: 'Listen to three 90-second hooks across genres.',
      coverUrl: 'https://picsum.photos/seed/brief3/900/600',
      durationLabel: '6m sampler',
      mood: 'Discover',
    ),
  ];
}
