import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart.dart'show Cart;
import 'package:shopapp/widgets/cart_item.dart' as ci;
import 'package:shopapp/providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text('\$${cart.totalAmount.toStringAsFixed(2)}'),
                    labelStyle: TextStyle(color: Theme.of(context).primaryTextTheme.title.color),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    onPressed: (){
                        Provider.of<Orders>(context,listen: false).addOrder(cart.items.values.toList(), cart.totalAmount);
                        cart.clear();
                    },
                    child: Text('ORDER NOW!'),textColor: Theme.of(context).primaryColor,)
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx,i)=> ci.CartItem(
                  cart.items.values.toList()[i].id,
                  cart.items.keys.toList()[i],
                  cart.items.values.toList()[i].price,
                  cart.items.values.toList()[i].quantity,
                  cart.items.values.toList()[i].title,
              ),
            ),
          )
        ],
      ),
    );
  }
}
