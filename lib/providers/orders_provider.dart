import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_flutter/models/cart_item.dart';
import 'package:shop_flutter/models/order.dart';
import 'package:shop_flutter/providers/cart_provider.dart';

class OrdersProvider with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemCount => _items.length;

  void addOrder(CartProvider cart) {
    _items.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: DateTime.now(),
      ),
    );

    notifyListeners();
  }
}
