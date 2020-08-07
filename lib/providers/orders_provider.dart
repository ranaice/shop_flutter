import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_flutter/models/cart_item.dart';
import 'package:shop_flutter/models/order.dart';
import 'package:shop_flutter/providers/cart_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shop_flutter/utils/constants.dart';

class OrdersProvider with ChangeNotifier {
  final String _baseUrl = '${Constants.BASE_URL}/orders';
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

  Future<void> loadOrders() async {
    final response = await http.get('$_baseUrl.json');
    Map<String, dynamic> data = jsonDecode(response.body);
    _items.clear();
    if (data != null) {
      data.forEach((orderId, orderData) {
        _items.add(
          Order(
              id: orderId,
              total: orderData['total'],
              products: (orderData['products'] as List<dynamic>)
                  .map((cartItem) => CartItem(
                      id: cartItem['id'],
                      productId: cartItem['productId'],
                      title: cartItem['title'],
                      quantity: cartItem['quantity'],
                      price: cartItem['price']))
                  .toList(),
              date: DateTime.parse(orderData['date'])),
        );
      });
    }

    _items = _items.reversed.toList();

    notifyListeners();
  }
}
