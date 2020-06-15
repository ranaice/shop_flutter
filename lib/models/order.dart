import 'package:flutter/foundation.dart';
import 'package:shop_flutter/models/cart_item.dart';

class Order {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime date;

  Order({
    @required this.id,
    @required this.total,
    this.products,
    this.date,
  });
}
