import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_flutter/exceptions/http_exception.dart';
import 'package:shop_flutter/models/product.dart';

class ProductsProvider with ChangeNotifier {
  // .json é uma regra do realtime db do firebase
  final String _baseUrl = 'https://shop-coder.firebaseio.com/products';
  List<Product> _products = [];

  List<Product> get products => [..._products];

  int get itemCount => _products.length;

  List<Product> get favoriteProducts {
    return _products.where((element) => element.isFavorite).toList();
  }

  Future<void> loadProducts() async {
    final response = await http.get('$_baseUrl.json');
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
    final response = await http.post('$_baseUrl.json', body: newProduct.toJson());

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

  Future<void> updateProduct(Product product) async {
    if (product == null || product.id == null) {
      return;
    }

    final index = _products.indexWhere((prod) => prod.id == product.id);

    if (index >= 0) {
      final response = await http.patch('$_baseUrl/${product.id}.json', body: product.toJson());
      _products[index] = product;
      notifyListeners();
    }
  }

  Future removeProduct(String id) async {
    final index = _products.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      final product = _products[index];
      _products.remove(product);
      notifyListeners();

      final response = await http.delete('$_baseUrl/${product.id}.json');

      if (response.statusCode >= 400) {
        _products.insert(index, product);
        notifyListeners();
        throw HttpException("Ocorreu um erro na exclusão do produto");
      }
    }
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
