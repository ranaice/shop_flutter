import 'package:flutter/material.dart';
import 'package:shop_flutter/models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget({Key key, this.cartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(4),
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              'Un.\n ${cartItem.price}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryTextTheme.headline6.color,
                fontSize: 12,
              ),
            ),
          ),
          title: Text(cartItem.title),
          subtitle: Text('Total: R\$ ${(cartItem.price * cartItem.quantity).toStringAsFixed(2)}'),
          trailing: Text('${cartItem.quantity}x'),
        ),
      ),
    );
  }
}
