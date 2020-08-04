import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_flutter/exceptions/http_exception.dart';
import 'package:shop_flutter/models/product.dart';
import 'package:shop_flutter/providers/products_provider.dart';
import 'package:shop_flutter/utils/routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaf = Scaffold.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.title),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.PRODUCT_FORM, arguments: product);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              onPressed: () {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: Text('Excluir Produto'),
                      content: Text('Deseja realmente excluir o item "${product.title}"'),
                      actions: <Widget>[
                        FlatButton(
                            child: Text('Não'),
                            onPressed: () {
                              Navigator.of(dialogContext).pop(); //Dismiss dialog
                            }),
                        FlatButton(
                            child: Text('Sim'),
                            onPressed: () async {
                              try {
                                await Provider.of<ProductsProvider>(context, listen: false).removeProduct(product.id);
                              } on HttpException catch (exception) {
                                scaf.showSnackBar(SnackBar(content: Text(exception.toString())));
                              } finally {
                                Navigator.of(dialogContext).pop(); //Dismiss dialog
                              }
                            }),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
