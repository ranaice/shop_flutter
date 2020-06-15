import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_flutter/models/cart_item.dart';
import 'package:shop_flutter/models/product.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount {
    return _items.length;
  }

  void addItem(Product product) {
    if (items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingProduct) => CartItem(
          id: existingProduct.id,
          title: existingProduct.title,
          quantity: existingProduct.quantity + 1,
          price: existingProduct.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(id: Random().nextDouble().toString(), title: product.title, quantity: 1, price: product.price),
      );
    }

    notifyListeners();
  }
}
