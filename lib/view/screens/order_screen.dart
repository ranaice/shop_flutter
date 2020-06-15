import 'package:flutter/material.dart';
import 'package:shop_flutter/view/widgets/app_drawer.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos'),
      ),
      body: Container(),
      drawer: AppDrawer(),
    );
  }
}
