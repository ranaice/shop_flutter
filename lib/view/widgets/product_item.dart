import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/providers/cart_provider.dart';
import 'package:shop_flutter/utils/routes.dart';
import '../../models/product.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product product = Provider.of<Product>(context, listen: false);
    CartProvider cart = Provider.of<CartProvider>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: GridTile(
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(Routes.PRODUCT_DETAIL, arguments: product),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black.withOpacity(0.7),
          leading: Consumer<Product>(
            builder: (BuildContext context, Product value, Widget child) => IconButton(
              icon: Icon(value.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Theme.of(context).accentColor,
              onPressed: () => value.toggleFavorite(),
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Produto adicionado com sucesso!'),
                  duration: Duration(
                    seconds: 2,
                  ),
                  action: SnackBarAction(
                    label: 'DESFAZER',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
              cart.addItem(product);
            },
          ),
        ),
      ),
    );
  }
}
