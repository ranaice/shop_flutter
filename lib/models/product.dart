import 'dart:convert';

import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
    };
  }

  static Product fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Product(
      title: map['title'],
      description: map['description'],
      price: double.parse(map['price']),
      imageUrl: map['imageUrl'],
      isFavorite: map['isFavorite'],
    );
  }

  String toJson() => json.encode(toMap());

  static Product fromJson(String source) => fromMap(json.decode(source));
}
