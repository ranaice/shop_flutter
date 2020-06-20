import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/providers/products_provider.dart';
import 'package:shop_flutter/view/widgets/app_drawer.dart';
import 'package:shop_flutter/view/widgets/product_item.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Produtos'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(8),
        itemCount: productsProvider.itemCount,
        itemBuilder: (_, int index) {
          return ProductItem(product: productsProvider.products[index]);
        },
        separatorBuilder: (_, __) => Divider(),
      ),
      drawer: AppDrawer(),
    );
  }
}
