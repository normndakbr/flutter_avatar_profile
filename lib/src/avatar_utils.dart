import 'package:flutter/material.dart';

Color nameToColor(String input) {
  // DJB2 Hash → Hue
  int hash = 5381;
  for (var c in input.codeUnits) {
    hash = ((hash << 5) + hash) + c;
  }
  final hue = (hash & 0xFFFF) % 360;

  final hsl = HSLColor.fromAHSL(1.0, hue.toDouble(), 0.56, 0.58);
  return hsl.toColor();
}

String initialsFromName(String? name, {int maxLetters = 2}) {
  if (name == null || name.trim().isEmpty) return '?';

  // Hapus gelar umum di Indonesia
  final cleaned = name
      .replaceAll(
        RegExp(r'(?i)\b(dr|drs|h|hj|ir|s\\.t|s\\.e|s\\.kom|m\\.m|mba)\b\.?'),
        '',
      )
      .trim();

  final words = cleaned
      .split(RegExp(r'\\s+'))
      .where((w) => w.isNotEmpty)
      .toList();
  if (words.isEmpty) return '?';

  // Nama tunggal → ambil n huruf depan
  if (words.length == 1) {
    return words[0]
        .substring(0, maxLetters.clamp(1, words[0].length))
        .toUpperCase();
  }

  // Nama lebih dari 1 kata → ambil huruf depan
  return words.take(maxLetters).map((w) => w[0].toUpperCase()).join();
}
