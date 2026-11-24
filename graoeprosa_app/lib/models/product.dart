import 'package:flutter/material.dart';

class Product {
  const Product({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.color,
    this.featured = false,
  });

  final String name;
  final String description;
  final double price;
  final String category;
  final Color color;

  /// Aparece em "Destaques" na tela inicial.
  final bool featured;

  String get priceLabel =>
      'R\$ ${price.toStringAsFixed(2).replaceAll('.', ',')}';
}
