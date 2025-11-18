import 'package:audiobook_ebooks/data/models/book.dart';
import 'package:audiobook_ebooks/data/models/chapter.dart';
import 'package:audiobook_ebooks/data/models/review.dart';

class DummyData {
  static final List<Book> books = List.generate(
    14,
    (index) => Book(
      id: 'book-$index',
      title: 'Fictional Odyssey $index',
      author: 'Author $index',
      genre: index % 2 == 0 ? 'Fiction' : 'History',
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
}
