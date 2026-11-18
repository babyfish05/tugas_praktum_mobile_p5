import 'package:flutter/material.dart';

/// Warna-warna utama aplikasi.
class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF5B4FE0); // indigo ungu
  static const Color background = Color(0xFFF4F5FF); // putih kebiruan
  static const Color soft = Color(0xFFE8E9FF); // indigo sangat muda
  static const Color border = Color(0xFFDDE0F5);
  static const Color text = Color(0xFF1E2140);
  static const Color muted = Color(0xFF7A7F9E);
  static const Color success = Color(0xFF14B8A6);
}

class AppStyle {
  AppStyle._();

  static List<BoxShadow> get softShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ];
}

/// Aturan ongkos kirim.
const int ongkosKirim = 8000;
const int minGratisOngkir = 50000;

/// SnackBar dengan gaya yang seragam di semua halaman.
void showAppSnackBar(
  ScaffoldMessengerState messenger,
  String message, {
  IconData icon = Icons.check_circle_rounded,
  SnackBarAction? action,
}) {
  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.text,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        action: action,
        content: Row(
          children: [
            Icon(icon, color: const Color(0xFF8BE9DA)),
            const SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );
}