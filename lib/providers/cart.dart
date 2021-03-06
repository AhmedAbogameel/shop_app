import 'package:flutter/widgets.dart';

class CartItem {
  CartItem(
      {@required this.title,
      @required this.id,
      @required this.price,
      @required this.quantity});

  final String id;
  final String title;
  final int quantity;
  final double price;
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount{
    var total = 0.0;
    _items.forEach((key, cartItem){
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void additem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCardItem) => CartItem(
            id: existingCardItem.id,
            title: existingCardItem.title,
            price: existingCardItem.price,
            quantity: existingCardItem.quantity + 1),
      );
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              title: title,
              id: DateTime.now().toString(),
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }
  void removeItem(String productId){
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId){
    if(!_items.containsKey(productId)){
      return;
    }
    if(_items[productId].quantity > 1){
      _items.update(productId, (existingCardItem)=> CartItem(title: existingCardItem.title, id: existingCardItem.id, price: existingCardItem.price, quantity: existingCardItem.quantity - 1));
    }
    else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear(){
    _items = {};
    notifyListeners();
  }

}
