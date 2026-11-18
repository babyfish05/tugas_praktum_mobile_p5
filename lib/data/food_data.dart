import '../models/food.dart';

const List<(String, String)> categories = [
  ('Semua', '☕'),
  ('Kopi', '☕'),
  ('Non-Kopi', '🍵'),
  ('Roti & Kue', '🥐'),
  ('Camilan', '🍟'),
];

const List<Food> foodList = [
  Food(
    id: 'f01',
    name: 'Kopi Susu Gula Aren',
    imageUrl:
        'https://commons.wikimedia.org/wiki/Special:FilePath/Iced_coffee.jpg?width=600',
    price: 22000,
    description:
        'Espresso dari biji arabika lokal dipadu susu segar dan sirup gula '
        'aren asli. Manisnya pas, aroma karamelnya wangi, paling enak '
        'diminum dingin dengan banyak es.',
    category: 'Kopi',
    emoji: '🧋',
    rating: 4.9,
    sold: 4200,
    prepMinutes: 5,
  ),
  Food(
    id: 'f02',
    name: 'Cafe Latte Hangat',
    imageUrl:
        'https://commons.wikimedia.org/wiki/Special:FilePath/Latte_art_3.jpg?width=600',
    price: 28000,
    description:
        'Double shot espresso dengan susu panas yang di-steam lembut dan '
        'dihias latte art. Creamy, seimbang, dan menenangkan di sore hari '
        'yang hujan.',
    category: 'Kopi',
    emoji: '☕',
    rating: 4.8,
    sold: 2650,
    prepMinutes: 6,
  ),
  Food(
    id: 'f03',
    name: 'Americano Dingin',
    imageUrl:
        'https://commons.wikimedia.org/wiki/Special:FilePath/Iced_americano.jpg?width=600',
    price: 20000,
    description:
        'Espresso pekat dengan air dingin dan es batu. Rasanya bersih, '
        'sedikit pahit, dan segar, pilihan tepat untuk yang suka kopi '
        'tanpa susu.',
    category: 'Kopi',
    emoji: '🧊',
    rating: 4.6,
    sold: 1890,
    prepMinutes: 4,
  ),
  Food(
    id: 'f04',
    name: 'Matcha Latte',
    imageUrl:
        'https://commons.wikimedia.org/wiki/Special:FilePath/Matcha_latte.jpg?width=600',
    price: 30000,
    description:
        'Bubuk matcha Jepang yang dikocok halus lalu dicampur susu segar. '
        'Gurih, sedikit manis, dengan aroma teh hijau yang khas. Bisa '
        'dipilih panas atau dingin.',
    category: 'Non-Kopi',
    emoji: '🍵',
    rating: 4.7,
    sold: 1720,
    prepMinutes: 6,
  ),
  Food(
    id: 'f05',
    name: 'Cokelat Panas Premium',
    imageUrl:
        'https://commons.wikimedia.org/wiki/Special:FilePath/Hot_chocolate.jpg?width=600',
    price: 26000,
    description:
        'Cokelat batangan asli yang dilelehkan bersama susu hangat, '
        'ditutup krim kocok dan taburan cokelat serut. Kental, manis, '
        'dan bikin hangat.',
    category: 'Non-Kopi',
    emoji: '🍫',
    rating: 4.6,
    sold: 980,
    prepMinutes: 7,
  ),
  Food(
    id: 'f06',
    name: 'Croissant Butter',
    imageUrl:
        'https://commons.wikimedia.org/wiki/Special:FilePath/Croissant-Table.jpg?width=600',
    price: 24000,
    description:
        'Croissant berlapis yang dipanggang dengan mentega berkualitas. '
        'Renyah di luar, lembut dan harum di dalam. Cocok untuk sarapan '
        'bersama kopi.',
    category: 'Roti & Kue',
    emoji: '🥐',
    rating: 4.8,
    sold: 2100,
    prepMinutes: 8,
  ),
  Food(
    id: 'f07',
    name: 'Banana Bread',
    imageUrl:
        'https://commons.wikimedia.org/wiki/Special:FilePath/Banana_bread.jpg?width=600',
    price: 22000,
    description:
        'Roti pisang buatan sendiri dengan potongan kenari dan sedikit '
        'kayu manis. Teksturnya moist dan manisnya alami dari pisang '
        'matang.',
    category: 'Roti & Kue',
    emoji: '🍞',
    rating: 4.7,
    sold: 870,
    prepMinutes: 5,
  ),
  Food(
    id: 'f08',
    name: 'Cheesecake Blueberry',
    imageUrl:
        'https://commons.wikimedia.org/wiki/Special:FilePath/Blueberry_cheesecake.jpg?width=600',
    price: 38000,
    description:
        'Cheesecake lembut dengan dasar biskuit renyah dan saus blueberry '
        'asam manis di atasnya. Dingin dan creamy, penutup yang sempurna.',
    category: 'Roti & Kue',
    emoji: '🍰',
    rating: 4.9,
    sold: 1330,
    prepMinutes: 5,
  ),
  Food(
    id: 'f09',
    name: 'Kentang Goreng Truffle',
    imageUrl:
        'https://commons.wikimedia.org/wiki/Special:FilePath/French_Fries.JPG?width=600',
    price: 27000,
    description:
        'Kentang goreng tipis renyah dengan taburan keju parmesan dan '
        'minyak truffle. Disajikan dengan saus mayo bawang putih.',
    category: 'Camilan',
    emoji: '🍟',
    rating: 4.5,
    sold: 1560,
    prepMinutes: 10,
  ),
  Food(
    id: 'f10',
    name: 'Pisang Cokelat Keju Toast',
    imageUrl:
        'https://commons.wikimedia.org/wiki/Special:FilePath/Toast_with_banana.jpg?width=600',
    price: 18000,
    description:
        'Roti tawar panggang tebal dengan irisan pisang, lelehan cokelat, '
        'dan parutan keju. Manis gurih, mengenyangkan, dan cepat disajikan.',
    category: 'Camilan',
    emoji: '🍌',
    rating: 4.6,
    sold: 1240,
    prepMinutes: 8,
  ),
];
