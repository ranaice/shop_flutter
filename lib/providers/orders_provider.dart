import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_flutter/models/cart_item.dart';
import 'package:shop_flutter/models/order.dart';
import 'package:shop_flutter/providers/cart_provider.dart';

class OrdersProvider with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(CartProvider cart) {
    _orders.insert(
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
