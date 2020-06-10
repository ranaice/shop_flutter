import 'package:flutter/material.dart';
import 'package:shop_flutter/utils/routes.dart';
import 'package:shop_flutter/view/screens/product_detail_screen.dart';
import './view/screens/products_overview_screen.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Loja',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.deepOrange,
        fontFamily: 'Lato',
      ),
      home: ProductOverviewScreen(),
      routes: {
        Routes.PRODUCT_DETAIL: (_) => ProductDetailScreen(),
      },
    );
  }
}
