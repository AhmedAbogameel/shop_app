import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products_provider.dart';
import 'package:shopapp/widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  ProductsGrid(this.showFavs);

  final bool showFavs;
  @override
  Widget build(BuildContext context) {
    final _provider = Provider.of<ProductsProvider>(context);
    final loadedProducts=showFavs ? _provider.favoriteItems : _provider.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: loadedProducts.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      itemBuilder: (ctx,i) => ChangeNotifierProvider.value(
        value: loadedProducts[i],
        child: ProductItem(

        ),
      ),
    );
  }
}