import 'package:flutter/material.dart';
import 'package:shop_flutter/mock/dummy_data.dart';
import 'package:shop_flutter/models/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _products = DUMMY_PRODUCTS;

  List<Product> get products => [..._products];

  List<Product> get favoriteProducts {
    return _products.where((element) => element.isFavorite).toList();
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
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
