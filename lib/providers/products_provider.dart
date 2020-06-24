import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_flutter/models/product.dart';

class ProductsProvider with ChangeNotifier {
  // .json é uma regra do realtime db do firebase
  final String _url = 'https://shop-coder.firebaseio.com/products.json';
  List<Product> _products = [];

  List<Product> get products => [..._products];

  int get itemCount => _products.length;

  List<Product> get favoriteProducts {
    return _products.where((element) => element.isFavorite).toList();
  }

  Future<void> loadProducts() async {
    final response = await http.get(_url);
    Map<String, dynamic> data = jsonDecode(response.body);
    _products.clear();
    if (data != null) {
      data.forEach((productId, productData) {
        _products.add(
          Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
            isFavorite: productData['isFavorite'],
          ),
        );
      });
    }

    notifyListeners();
  }

  Future addProduct(Product newProduct) async {
    final response = await http.post(_url, body: newProduct.toJson());

    _products.add(
      Product(
        id: jsonDecode(response.body)['name'],
        title: newProduct.title,
        description: newProduct.description,
        price: newProduct.price,
        imageUrl: newProduct.imageUrl,
      ),
    );
    notifyListeners();
  }

  void updateProduct(Product product) {
    if (product == null || product.id == null) {
      return;
    }

    final index = _products.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      _products[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(String id) {
    _products.removeWhere((element) => element.id == id);
    notifyListeners();
  }
  // bool _showFavoriteOnly = false;

  // void showFavoriteOnly() {
  //   _showFavoriteOnly = true;
  //   notifyListeners();
  // }

  // void showFavoriteAll() {
  //   _showFavoriteOnly = false;
  //   notifyListeners();
  // }
}
