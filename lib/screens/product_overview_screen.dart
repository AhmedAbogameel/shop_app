import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/providers/products_provider.dart';
import 'package:shopapp/screens/cart_screen.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/badge.dart';
import 'package:shopapp/widgets/products_grid.dart';

enum FilterOptions{
  Favorites,
  All
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {

  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {

//    final productsContainer = Provider.of<ProductsProvider>(context,listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (FilterOptions val){
              setState(() {
                if(val == FilterOptions.Favorites){
//                productsContainer.showFavoritesOnly();
                  _showOnlyFavorites = true;
                }else{
//                productsContainer.showAll();
                  _showOnlyFavorites = false;
                }
              });
            },
            itemBuilder: (_)=> [
              PopupMenuItem(child: Text('Only Favorites'),value: FilterOptions.Favorites,),
              PopupMenuItem(child: Text('Show All'),value: FilterOptions.All,),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch)=>Badge(
              child: ch,
              value: '${cart.itemCount}',
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: (){
                Navigator.pushNamed(context, CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}