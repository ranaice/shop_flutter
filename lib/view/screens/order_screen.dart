import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/providers/orders_provider.dart';
import 'package:shop_flutter/view/widgets/app_drawer.dart';
import 'package:shop_flutter/view/widgets/order_widget.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos'),
      ),
      body: FutureBuilder(
        future: Provider.of<OrdersProvider>(context, listen: false).loadOrders(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Consumer<OrdersProvider>(builder: (context, orders, child) {
              return ListView.builder(
                itemCount: orders.itemCount,
                itemBuilder: (BuildContext context, int index) {
                  final order = orders.items[index];
                  return OrderWidget(
                    order: order,
                  );
                },
              );
            });
          }
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
