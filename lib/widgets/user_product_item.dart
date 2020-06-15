import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopapp/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products_provider.dart';

class UserProductItem extends StatelessWidget {
  UserProductItem(this.id, this.title, this.imageUrl);

  final String id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.edit),
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.pushNamed(context, EditProductScreen.routeName,
                      arguments: id);
                }),
            IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () async {
                  try {
                    await Provider.of<ProductsProvider>(context, listen: false)
                        .deleteProduct(id);
                  } catch (e) {
                    scaffold.showSnackBar(
                        SnackBar(content: Text('Deleting failed!',textAlign: TextAlign.center,)));
                  }
                }),
          ],
        ),
      ),
    );
  }
}
