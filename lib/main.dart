import 'package:flutter/material.dart';
import 'package:shopapp/providers/auth.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/providers/orders.dart';
import 'package:shopapp/screens/auth_screen.dart';
import 'package:shopapp/screens/cart_screen.dart';
import 'package:shopapp/screens/edit_product_screen.dart';
import 'package:shopapp/screens/orders_screen.dart';
import 'package:shopapp/screens/product_detail_screen.dart';
import 'package:shopapp/screens/product_overview_screen.dart';
import 'package:shopapp/providers/products_provider.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/screens/splash_screen.dart';
import 'package:shopapp/screens/user_products_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth , ProductsProvider>(
          create: (BuildContext context)=> null,
          update: (ctx , auth , previousProducts)=> ProductsProvider(auth.token,auth.userId , previousProducts== null ? [] : previousProducts.items),
        ),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProxyProvider<Auth ,Orders>(
          create: (context)=> null,
          update: (ctx ,auth , previousOrder )=> Orders(auth.token , auth.userId , previousOrder == null ? [] : previousOrder.orders),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx , auth , _)=> MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato'
          ),
          home: auth.isAuth ? ProductOverviewScreen() : FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (ctx , authRseultSnapshot) => authRseultSnapshot.connectionState == ConnectionState.waiting ? SplashScreen() :  AuthScreen(),
          ),
          routes: {
            ProductDetailScreen.routeName:(ctx)=> ProductDetailScreen(),
            CartScreen.routeName : (ctx)=> CartScreen(),
            OrdersScreen.routeName : (ctx)=> OrdersScreen(),
            UserProductsScreen.routeName : (ctx)=> UserProductsScreen(),
            EditProductScreen.routeName : (ctx)=> EditProductScreen(),
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MyShop'),),
      body: Center(
        child: Text('Let\'s build a shop'),
      ),
    );
  }
}