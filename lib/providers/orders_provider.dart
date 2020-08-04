import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_flutter/models/cart_item.dart';
import 'package:shop_flutter/models/order.dart';
import 'package:shop_flutter/providers/cart_provider.dart';
import 'package:http/http.dart' as http;

class OrdersProvider with ChangeNotifier {
  final String _baseUrl = 'https://shop-coder.firebaseio.com/orders';
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  int get itemCount => _items.length;

  Future addOrder(CartProvider cart) async {
    final date = DateTime.now();
    final response = await http.post('$_baseUrl.json',
        body: json.encode({
          'total': cart.totalAmount,
          'date': date.toIso8601String(),
          'products': cart.items.values
              .map((cartItem) => {
                    'id': cartItem.id,
                    'productId': cartItem.productId,
                    'title': cartItem.title,
                    'quantity': cartItem.quantity,
                    'price': cartItem.price,
                  })
              .toList(),
        }));

    _items.insert(
      0,
      Order(
        id: json.decode(response.body)['name'],
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: date,
      ),
    );

    notifyListeners();
  }
}
