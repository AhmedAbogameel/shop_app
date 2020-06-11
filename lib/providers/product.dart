import 'package:flutter/widgets.dart';

class Product with ChangeNotifier{
  Product({
    this.isFavorite = false,
    @required this.title,
    @required this.imageUrl,
    @required this.id,
    @required this.description,
    @required this.price,
});

  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  void toggleFavoriteStatus(){
    isFavorite = !isFavorite;
    notifyListeners();
  }

}