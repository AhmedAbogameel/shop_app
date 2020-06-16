import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

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

  void _setFavValue(bool newValue){
    isFavorite = newValue;
    notifyListeners();
  }

  void toggleFavoriteStatus()async{
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url = 'https://shop-app-dcff6.firebaseio.com/products/$id.json';
    try{
      final response = await http.patch(url,body: json.encode({
        'isFavorite':isFavorite,
      }));
      if(response.statusCode >= 400){
        _setFavValue(oldStatus);
      }
    }catch(e){
      _setFavValue(oldStatus);
    }
  }

}