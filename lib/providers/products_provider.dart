import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_flutter/mock/dummy_data.dart';
import 'package:shop_flutter/models/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = DUMMY_PRODUCTS;

  List<Product> get products => [..._products];

  int get itemCount => _products.length;

  List<Product> get favoriteProducts {
    return _products.where((element) => element.isFavorite).toList();
  }

  Future addProduct(Product newProduct) async {
    // .json é uma regra do realtime db do firebase
    const url = 'https://shop-coder.firebaseio.com/products';

    final response = await http.post(url, body: newProduct.toJson());

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
