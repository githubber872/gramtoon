import '../models/book.dart';

// Sample data taken from the Gramtoon design. Descriptions are short
// placeholders except where noted; replace them with your own text.

final List<Book> popularBooks = [
  Book(
    title: 'Kagurabachi 01',
    category: 'Action thriller',
    price: 45000,
    description:
        'Chihiro trains to become a sword smith under the guidance of his '
        'father, the most famous sword smith in the entire country. A witty '
        'father and a quiet son, although different in nature, share a bond '
        'forged through the blade.',
    coverAsset: 'assets/covers/kagurabachi_01.png',
  ),
  Book(
    title: 'Jakarta Sebelum Pagi',
    category: 'Slice of Life',
    price: 95000,
    description: 'A quiet story about the people of Jakarta before sunrise.',
    coverAsset: 'assets/covers/jakarta_sebelum_pagi.png',
  ),
  Book(
    title: "Komi Can't Communicate 23",
    category: 'Romance',
    price: 45000,
    description: 'Komi keeps working toward her goal of making 100 friends.',
    coverAsset: 'assets/covers/komi_23.png',
  ),
  Book(
    title: 'Journey To Allah',
    category: 'Religion',
    price: 120000,
    description: 'A reflective book about faith and personal growth.',
    coverAsset: 'assets/covers/journey_to_allah.png',
  ),
  Book(
    title: 'Dandadan 02',
    category: 'Supernatural Comedy',
    price: 45000,
    description: 'Aliens, ghosts and two unlikely partners.',
    coverAsset: 'assets/covers/dandadan_02.png',
  ),
  Book(
    title: 'Alya Sometimes Hides Her Feelings In Russian 04',
    category: 'Romance',
    price: 108000,
    description: 'Alya says what she really feels in Russian. Masachika understands more than he shows.',
    coverAsset: 'assets/covers/alya_04.png',
  ),
  // Price not visible in the recording; change it to the real one.
  Book(
    title: 'Jujutsu Kaisen 19',
    category: 'Dark Fantasy',
    price: 45000,
    description: 'Sorcerers fight cursed spirits in a world of curses.',
    coverAsset: 'assets/covers/jujutsu_kaisen_19.png',
  ),
];

final List<Book> newReleases = [
  Book(title: 'Sakamoto Days 06', category: 'Action', price: 36000, coverAsset: 'assets/covers/sakamoto_days_06.png'),
  Book(title: 'One Piece 104', category: 'Adventure', price: 45000, coverAsset: 'assets/covers/one_piece_104.png'),
  Book(title: 'One Punch Man 28', category: 'Action Supernatural', price: 45000, coverAsset: 'assets/covers/one_punch_man_28.png'),
  Book(title: 'Firasat', category: 'Psychology', price: 28000, coverAsset: 'assets/covers/firasat.png'),
  Book(title: 'Over Love Weight', category: 'Romance psychology', price: 30000, coverAsset: 'assets/covers/over_love_weight.png'),
  Book(title: 'Positivity', category: 'Psychology', price: 75000, coverAsset: 'assets/covers/positivity.png'),
  Book(title: 'Si Juki Keroyokan #7', category: 'Comedy', price: 20000, coverAsset: 'assets/covers/si_juki_7.png'),
  Book(title: 'Kosmos', category: 'Science', price: 45000, coverAsset: 'assets/covers/kosmos.png'),
  Book(title: 'Rascal Does Not Dream of Bunny Girl Senpai 02', category: 'Romance', price: 60000, coverAsset: 'assets/covers/rascal_02.png'),
  Book(title: 'The Eminence in Shadow 01', category: 'Dark Fantasy', price: 85000, coverAsset: 'assets/covers/eminence_in_shadow_01.png'),
];

// Normal price Rp 45.000 with 20% off = Rp 36.000, as in the design.
final Book bookOfTheDay = Book(
  title: 'Cells at Work! 06',
  category: 'Science biology',
  price: 45000,
  discountPercent: 20,
  description:
      '"Cells at Work! BLACK" is a spin-off of the popular manga about the '
      'human body. It follows the red blood cell and the white blood cell '
      'inside an unhealthy body.',
  coverAsset: 'assets/covers/cells_at_work_06.png',
);
