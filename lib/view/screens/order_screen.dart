import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/providers/orders_provider.dart';
import 'package:shop_flutter/view/widgets/app_drawer.dart';
import 'package:shop_flutter/view/widgets/order_widget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<OrdersProvider>(context, listen: false).loadOrders().then((_) => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final OrdersProvider orders = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: orders.itemCount,
              itemBuilder: (BuildContext context, int index) {
                final order = orders.items[index];
                return OrderWidget(
                  order: order,
                );
              },
            ),
      drawer: AppDrawer(),
    );
  }
}
