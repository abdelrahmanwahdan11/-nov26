import 'package:audiobook_ebooks/data/models/achievement.dart';
import 'package:audiobook_ebooks/data/models/app_notification.dart';
import 'package:audiobook_ebooks/data/models/author_spotlight.dart';
import 'package:audiobook_ebooks/data/models/book.dart';
import 'package:audiobook_ebooks/data/models/chapter.dart';
import 'package:audiobook_ebooks/data/models/community_story.dart';
import 'package:audiobook_ebooks/data/models/curated_collection.dart';
import 'package:audiobook_ebooks/data/models/download_item.dart';
import 'package:audiobook_ebooks/data/models/daily_brief.dart';
import 'package:audiobook_ebooks/data/models/coach_tip.dart';
import 'package:audiobook_ebooks/data/models/immersion_mix.dart';
import 'package:audiobook_ebooks/data/models/journey_event.dart';
import 'package:audiobook_ebooks/data/models/listening_club.dart';
import 'package:audiobook_ebooks/data/models/live_session.dart';
import 'package:audiobook_ebooks/data/models/highlight_note.dart';
import 'package:audiobook_ebooks/data/models/reading_stat.dart';
import 'package:audiobook_ebooks/data/models/review.dart';
import 'package:audiobook_ebooks/data/models/scheduled_event.dart';
import 'package:audiobook_ebooks/data/models/learning_path.dart';
import 'package:audiobook_ebooks/data/models/mindful_moment.dart';
import 'package:audiobook_ebooks/data/models/ritual_blueprint.dart';

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

  static const scheduledEvents = [
    ScheduledEvent(
      id: 'sunrise-stack',
      title: 'Sunrise stack',
      window: 'Tomorrow · 6:30 AM',
      subtitle: 'Breathing primer + mindful chapter to open the day.',
      coverUrl: 'https://picsum.photos/seed/schedule1/900/600',
      vibe: 'Calm focus',
    ),
    ScheduledEvent(
      id: 'noon-dive',
      title: 'Noon deep dive',
      window: 'Tomorrow · 12:15 PM',
      subtitle: 'Drop into a 20m immersion mix and quick chapter recap.',
      coverUrl: 'https://picsum.photos/seed/schedule2/900/600',
      vibe: 'Productivity',
    ),
    ScheduledEvent(
      id: 'commute-companion',
      title: 'Commute companion',
      window: 'Fri · 5:40 PM',
      subtitle: 'Soft narration with upbeat outro to reset after work.',
      coverUrl: 'https://picsum.photos/seed/schedule3/900/600',
      vibe: 'Reset',
    ),
    ScheduledEvent(
      id: 'night-wind',
      title: 'Night wind-down',
      window: 'Fri · 10:05 PM',
      subtitle: 'Cozy stories with gentle rain textures before sleep.',
      coverUrl: 'https://picsum.photos/seed/schedule4/900/600',
      vibe: 'Sleep',
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

  static const highlights = [
    HighlightNote(
      id: 'h1',
      bookTitle: 'Fictional Odyssey',
      chapterTitle: 'Chapter 3 · Whispered horizons',
      snippet: '"Hold steady—storms show who we are when no one is watching."',
      mood: 'Focus',
      coverUrl: 'https://picsum.photos/seed/highlight1/400/400',
      timeLabel: 'Today · 7:30 AM',
      tags: ['Reflection', 'Share-ready', 'Mark for recap'],
    ),
    HighlightNote(
      id: 'h2',
      bookTitle: 'Nightfall Narratives',
      chapterTitle: 'Chapter 8 · Low ember glow',
      snippet: '"Rest is not idle; it is how the next idea learns to breathe."',
      mood: 'Calm',
      coverUrl: 'https://picsum.photos/seed/highlight2/400/400',
      timeLabel: 'Yesterday · 10:12 PM',
      tags: ['Sleep', 'Save for later'],
    ),
    HighlightNote(
      id: 'h3',
      bookTitle: 'Mindful Mornings',
      chapterTitle: 'Segment 2 · Breathing room',
      snippet: '"Small breaths stack into courage when the day speeds up."',
      mood: 'Renew',
      coverUrl: 'https://picsum.photos/seed/highlight3/400/400',
      timeLabel: '2 days ago',
      tags: ['Share', 'Clip to daily brief'],
    ),
  ];

  static const coachTips = [
    CoachTip(
      id: 'c1',
      title: 'Tame busy mornings',
      subtitle: 'Blend a 6m calm mix with a 4m story hook to keep energy steady.',
      actionLabel: 'Build stack',
      illustrationUrl: 'https://picsum.photos/seed/coach1/900/600',
    ),
    CoachTip(
      id: 'c2',
      title: 'Protect your streak',
      subtitle: 'Schedule a 12m night drift with slow fades before you unplug.',
      actionLabel: 'Schedule drift',
      illustrationUrl: 'https://picsum.photos/seed/coach2/900/600',
    ),
    CoachTip(
      id: 'c3',
      title: 'Learn + Recall',
      subtitle: 'Pair a 90s recap with a fresh chapter to anchor the memory.',
      actionLabel: 'Add recap',
      illustrationUrl: 'https://picsum.photos/seed/coach3/900/600',
    ),
  ];

  static const learningPaths = [
    LearningPath(
      id: 'focus-foundation',
      title: 'Focus foundation',
      subtitle: 'Blend mindful breath + highlight recap for 10 days.',
      focus: 'focus',
      progress: 0.45,
      steps: [
        '2m breath check-in',
        '8m chapter dive',
        'Mark a takeaway',
        'Log a micro reflection',
      ],
      coverUrl: 'https://picsum.photos/seed/path1/900/600',
      minutesPerDay: 12,
      featured: true,
      tags: ['Morning', 'Solo', 'Streak'],
    ),
    LearningPath(
      id: 'calm-evenings',
      title: 'Calm evenings',
      subtitle: 'Wind down with soft narration and gentle journaling cues.',
      focus: 'calm',
      progress: 0.7,
      steps: [
        '5m body scan',
        'Story chapter with dim visuals',
        'Note gratitude highlight',
      ],
      coverUrl: 'https://picsum.photos/seed/path2/900/600',
      minutesPerDay: 15,
      featured: true,
      tags: ['Night', 'Cozy', 'Breath'],
    ),
    LearningPath(
      id: 'growth-lab',
      title: 'Growth lab',
      subtitle: 'Rotate two genres weekly and record insights.',
      focus: 'growth',
      progress: 0.25,
      steps: [
        'Pick a mentor book',
        'Listen 15m/day',
        'Share one quote',
      ],
      coverUrl: 'https://picsum.photos/seed/path3/900/600',
      minutesPerDay: 20,
      featured: false,
      tags: ['Community', 'Clubs'],
    ),
    LearningPath(
      id: 'reset-sprint',
      title: 'Reset sprint',
      subtitle: 'Mini detox with breathing cues and inspiring shorts.',
      focus: 'calm',
      progress: 0.9,
      steps: [
        '3m breathing arc',
        '6m inspiration clip',
        'Log mood shift',
      ],
      coverUrl: 'https://picsum.photos/seed/path4/900/600',
      minutesPerDay: 9,
      featured: false,
      tags: ['Daytime', 'Quick'],
    ),
  ];

  static const mindfulMoments = [
    MindfulMoment(
      id: 'sun-dial',
      title: 'Sun dial reset',
      description:
          'Let warm synth pads lead a slow inhale/exhale while narrators whisper a grounding mantra.',
      mood: 'Calm',
      durationLabel: '4m',
      coverUrl: 'https://picsum.photos/seed/moment1/900/600',
      cues: ['Warm light', 'Slow inhale', 'Hold + exhale'],
    ),
    MindfulMoment(
      id: 'pulse-tide',
      title: 'Pulse tide boost',
      description:
          'A gentle metronome pairs with upbeat narration to lift afternoon slumps.',
      mood: 'Focus',
      durationLabel: '6m',
      coverUrl: 'https://picsum.photos/seed/moment2/900/600',
      cues: ['Tap to tempo', 'Smile cue', 'Quick stretch'],
    ),
    MindfulMoment(
      id: 'starlit',
      title: 'Starlit hush',
      description:
          'Dim textures, breath-counting, and a tender bedtime story preview.',
      mood: 'Sleep',
      durationLabel: '5m',
      coverUrl: 'https://picsum.photos/seed/moment3/900/600',
      cues: ['Count backwards', 'Wrap in blanket', 'Whisper mantra'],
    ),
    MindfulMoment(
      id: 'fresh-page',
      title: 'Fresh page spark',
      description:
          'Morning note-to-self, posture check, and a quote to set intentions.',
      mood: 'Inspire',
      durationLabel: '3m',
      coverUrl: 'https://picsum.photos/seed/moment4/900/600',
      cues: ['Sit tall', 'Note one win', 'Share the vibe'],
    ),
  ];

  static const communityStories = [
    CommunityStory(
      id: 'cs1',
      userName: 'Maya',
      userAvatarUrl: 'https://picsum.photos/seed/community1/100/100',
      coverUrl: 'https://picsum.photos/seed/communitycard1/600/400',
      snippet:
          'Stacked a 9-minute calm mix with a gratitude clip before sunrise. Energy stayed grounded all morning.',
      mood: 'Calm',
      minutes: 9,
      likes: 214,
      comments: 12,
      timeAgo: '5m ago',
    ),
    CommunityStory(
      id: 'cs2',
      userName: 'Omar',
      userAvatarUrl: 'https://picsum.photos/seed/community2/100/100',
      coverUrl: 'https://picsum.photos/seed/communitycard2/600/400',
      snippet:
          'Mixed a sci-fi short with the breathing slider at 70%. Logged the best focus sprint yet.',
      mood: 'Focus',
      minutes: 14,
      likes: 188,
      comments: 20,
      timeAgo: '20m ago',
    ),
    CommunityStory(
      id: 'cs3',
      userName: 'Lina',
      userAvatarUrl: 'https://picsum.photos/seed/community3/100/100',
      coverUrl: 'https://picsum.photos/seed/communitycard3/600/400',
      snippet:
          'Night drift playlist with soft rain + narrative whispers helped me fall asleep in 6 minutes.',
      mood: 'Sleep',
      minutes: 6,
      likes: 301,
      comments: 33,
      timeAgo: '1h ago',
    ),
    CommunityStory(
      id: 'cs4',
      userName: 'Yasmin',
      userAvatarUrl: 'https://picsum.photos/seed/community4/100/100',
      coverUrl: 'https://picsum.photos/seed/communitycard4/600/400',
      snippet:
          'Turned highlights into a lunchtime recap for my club—instant inspiration and lively replies.',
      mood: 'Community',
      minutes: 11,
      likes: 129,
      comments: 15,
      timeAgo: '2h ago',
    ),
  ];

  static const ritualBlueprints = [
    RitualBlueprint(
      id: 'rb-sunrise',
      title: 'Sunrise lift',
      description: 'Soft light cues, journal check-in, and uplifting narration.',
      focus: 'Calm',
      durationMinutes: 12,
      steps: [
        '2m breath sync',
        '6m inspiring chapter',
        '2m gratitude jot',
        '2m share a highlight',
      ],
    ),
    RitualBlueprint(
      id: 'rb-focus-surge',
      title: 'Focus surge',
      description: 'Intense yet gentle stack for getting into deep work.',
      focus: 'Focus',
      durationMinutes: 15,
      steps: [
        '3m breath ramp',
        '8m sci-fi short',
        '2m stretch + sip',
        '2m log momentum',
      ],
    ),
    RitualBlueprint(
      id: 'rb-night-hush',
      title: 'Night hush',
      description: 'Slow narration, dim visuals, and sleep affirmations.',
      focus: 'Sleep',
      durationMinutes: 10,
      steps: [
        '2m body scan',
        '5m cozy story',
        '3m whisper mantra',
      ],
    ),
  ];

  static const ritualIdeas = [
    'Sunlight check-in',
    'Desk stretch reset',
    'Slow coffee reflection',
    'Community share prompt',
    'Night gratitude ping',
  ];

  static const microTasks = [
    'Mark a highlight for tonight\'s recap',
    'Share a calm quote with your club',
    'Pin a focus brief to the planner',
    'Log 5 minutes to keep the streak glowing',
  ];
}
