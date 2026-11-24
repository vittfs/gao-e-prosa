import 'package:flutter/material.dart';

class ProductOption {
  final String label;
  final double priceDelta;

  const ProductOption({
    required this.label,
    this.priceDelta = 0.0,
  });
}

class Product {
  final String id;
  final String name;
  final String shortSubtitle;
  final String description;
  final double basePrice;
  final String category; // 'Cafés' ou 'Salgados'
  final Color cardColor;
  final bool isFeatured;
  final List<ProductOption> options;

  const Product({
    required this.id,
    required this.name,
    required this.shortSubtitle,
    required this.description,
    required this.basePrice,
    required this.category,
    required this.cardColor,
    this.isFeatured = false,
    required this.options,
  });
}

class CartItem {
  final Product product;
  final ProductOption selectedOption;
  int quantity;

  CartItem({
    required this.product,
    required this.selectedOption,
    this.quantity = 1,
  });

  double get unitPrice => product.basePrice + selectedOption.priceDelta;
  double get totalPrice => unitPrice * quantity;
}
