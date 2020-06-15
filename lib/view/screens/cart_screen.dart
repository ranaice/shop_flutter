import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/providers/cart_provider.dart';
import 'package:shop_flutter/providers/orders_provider.dart';
import 'package:shop_flutter/view/widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartItems = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(5),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 10.0),
                    Chip(
                      label: Text(
                        'R\$ ${cart.totalAmount}',
                        style: TextStyle(
                            color: Theme.of(context).primaryTextTheme.headline6.color, fontWeight: FontWeight.w700),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    Spacer(),
                    FlatButton(
                      onPressed: () {
                        Provider.of<OrdersProvider>(context, listen: false).addOrder(cart);
                        cart.clear();
                      },
                      child: Text('COMPRAR'),
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cart.itemCount,
                itemBuilder: (BuildContext context, int index) {
                  final product = cartItems[index];

                  return CartItemWidget(
                    cartItem: product,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
