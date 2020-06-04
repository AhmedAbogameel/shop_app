import 'package:flutter/material.dart';
import 'package:shopapp/providers/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/screens/edit_product_screen.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {

    final productsData = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title:const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon:const Icon(Icons.add),
            onPressed: (){
              Navigator.pushNamed(context, EditProductScreen.routeName);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_ , i)=> Column(
              children: <Widget>[
                UserProductItem(productsData.items[i].title, productsData.items[i].imageUrl),
                Divider(),
              ],
            ),
          ),
      ),
    );
  }
}
