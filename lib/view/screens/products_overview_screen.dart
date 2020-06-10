import 'package:flutter/material.dart';
import 'package:shop_with_provider/mock/dummy_data.dart';
import 'package:shop_with_provider/models/product.dart';
import 'package:shop_with_provider/view/widgets/product_item.dart';

class ProductOverviewScreen extends StatelessWidget {
  final List<Product> loadedProducts = DUMMY_PRODUCTS;

  ProductOverviewScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja'),
      ),
      body: GridView.builder(
          padding: EdgeInsets.all(10.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: loadedProducts.length,
          itemBuilder: (_, index) {
            return ProductItem(
              product: loadedProducts[index],
            );
          }),
    );
  }
}
