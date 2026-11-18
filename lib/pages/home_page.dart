import 'package:flutter/material.dart';
import '../data/food_data.dart';
import '../models/cart_item.dart';
import '../models/food.dart';
import '../utils/app_style.dart';
import '../utils/formatter.dart';
import '../widgets/food_card.dart';
import '../widgets/food_image.dart';
import 'cart_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = 'Semua';
  String _keyword = '';
  final List<CartItem> _cart = [];

  int get _cartCount => _cart.fold(0, (sum, item) => sum + item.quantity);
  int get _cartTotal => _cart.fold(0, (sum, item) => sum + item.subtotal);

  /// Menu yang sesuai kategori & kata kunci pencarian.
  List<Food> get _filteredFoods {
    final keyword = _keyword.trim().toLowerCase();
    return foodList.where((food) {
      final matchCategory =
          _selectedCategory == 'Semua' || food.category == _selectedCategory;
      final matchKeyword = keyword.isEmpty ||
          food.name.toLowerCase().contains(keyword) ||
          food.category.toLowerCase().contains(keyword);
      return matchCategory && matchKeyword;
    }).toList();
  }

  /// 4 menu dengan penjualan terbanyak.
  List<Food> get _bestSellers {
    final sorted = [...foodList]..sort((a, b) => b.sold.compareTo(a.sold));
    return sorted.take(4).toList();
  }

  /// Tambah ke keranjang. Kalau menu & catatannya sama, jumlahnya digabung.
  void _addToCart(CartItem newItem) {
    setState(() {
      final index = _cart.indexWhere((item) => item.isSameAs(newItem));
      if (index >= 0) {
        final item = _cart[index];
        item.quantity = (item.quantity + newItem.quantity).clamp(1, 99).toInt();
      } else {
        _cart.add(newItem);
      }
    });
  }

  /// Tombol "+" di kartu: langsung tambah 1 porsi.
  void _quickAdd(Food food) {
    _addToCart(CartItem(food: food, quantity: 1));
    showAppSnackBar(
      ScaffoldMessenger.of(context),
      '1x ${food.name} masuk keranjang',
    );
  }

  void _openDetail(Food food) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailPage(food: food, onAddToCart: _addToCart),
      ),
    );
  }

  void _openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CartPage(
          cart: _cart,
          onChanged: () => setState(() {}),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final foods = _filteredFoods;
    final isBrowsing = _keyword.trim().isEmpty && _selectedCategory == 'Semua';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHero()),
          if (isBrowsing) SliverToBoxAdapter(child: _buildShippingChip()),
          SliverToBoxAdapter(child: _buildCategories()),
          if (isBrowsing) ...[
            SliverToBoxAdapter(
              child: _sectionTitle('Paling Laris', subtitle: 'Minggu ini'),
            ),
            SliverToBoxAdapter(child: _buildBestSellers()),
          ],
          SliverToBoxAdapter(
            child: _sectionTitle(
              isBrowsing ? 'Semua Menu' : 'Hasil Pencarian',
              subtitle: '${foods.length} menu',
            ),
          ),
          if (foods.isEmpty)
            SliverFillRemaining(hasScrollBody: false, child: _buildEmpty())
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final food = foods[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: FoodCard(
                        key: ValueKey(food.id),
                        food: food,
                        onTap: () => _openDetail(food),
                        onAdd: () => _quickAdd(food),
                      ),
                    );
                  },
                  childCount: foods.length,
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: _cartCount == 0 ? null : _buildCartBar(),
    );
  }

  // ================= HERO (header + pencarian) =================
  Widget _buildHero() {
    final top = MediaQuery.of(context).padding.top;
    return Container(
      padding: EdgeInsets.fromLTRB(20, top + 18, 20, 24),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(34)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Halo, mau ngopi apa hari ini?',
                      style: TextStyle(color: Color(0xFFD9D5FF), fontSize: 13.5),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Kopi Senja',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
              Badge(
                isLabelVisible: _cartCount > 0,
                backgroundColor: AppColors.success,
                label: Text('$_cartCount'),
                offset: const Offset(-2, 2),
                child: Material(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: _openCart,
                    child: const SizedBox(
                      width: 48,
                      height: 48,
                      child: Icon(Icons.shopping_cart_outlined,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              onChanged: (value) => setState(() => _keyword = value),
              decoration: const InputDecoration(
                hintText: 'Cari latte, croissant, matcha...',
                hintStyle: TextStyle(color: AppColors.muted, fontSize: 14),
                prefixIcon: Icon(Icons.search_rounded, color: AppColors.primary),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= INFO ONGKIR =================
  Widget _buildShippingChip() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.soft,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            const Icon(Icons.local_shipping_outlined,
                size: 20, color: AppColors.primary),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Gratis ongkir untuk belanja min. ${formatRupiah(minGratisOngkir)}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= KATEGORI (ikon bulat + label) =================
  Widget _buildCategories() {
    return SizedBox(
      height: 98,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 18),
        itemBuilder: (context, index) {
          final (name, emoji) = categories[index];
          final selected = name == _selectedCategory;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = name),
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 54,
                  height: 54,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary : Colors.white,
                    borderRadius: BorderRadius.circular(selected ? 27 : 18),
                    border: Border.all(
                      color: selected ? AppColors.primary : AppColors.border,
                    ),
                  ),
                  child: Text(emoji, style: const TextStyle(fontSize: 24)),
                ),
                const SizedBox(height: 6),
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
                    color: selected ? AppColors.primary : AppColors.muted,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ================= PALING LARIS (kartu potret) =================
  Widget _buildBestSellers() {
    final foods = _bestSellers;
    return SizedBox(
      height: 222,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: foods.length,
        separatorBuilder: (context, index) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final food = foods[index];
          return GestureDetector(
            onTap: () => _openDetail(food),
            child: Container(
              width: 156,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 116,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: FoodImage(food: food, emojiSize: 44),
                          ),
                        ),
                        Positioned(
                          top: 6,
                          left: 6,
                          child: Container(
                            width: 26,
                            height: 26,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: AppColors.text,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    food.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                      height: 1.25,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    formatRupiah(food.price),
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    '${formatSold(food.sold)} terjual',
                    style: const TextStyle(fontSize: 11, color: AppColors.muted),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ================= BAR KERANJANG DI BAWAH =================
  Widget _buildCartBar() {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
        child: Material(
          color: AppColors.text,
          borderRadius: BorderRadius.circular(28),
          child: InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: _openCart,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$_cartCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Lihat keranjang',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    formatRupiah(_cartTotal),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.chevron_right_rounded, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================= LAIN-LAIN =================
  Widget _sectionTitle(String title, {String? subtitle}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 4,
            height: 18,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.text,
              ),
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12.5, color: AppColors.muted),
            ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('🔍', style: TextStyle(fontSize: 52)),
            SizedBox(height: 12),
            Text(
              'Menu tidak ditemukan',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.text,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Coba kata kunci atau kategori lain ya.',
              style: TextStyle(color: AppColors.muted),
            ),
          ],
        ),
      ),
    );
  }
}
