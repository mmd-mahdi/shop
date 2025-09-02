
import 'package:flutter/material.dart';
import 'package:myapp/models/product.dart';

class FavoriteViewModel extends ChangeNotifier {
  final List<Product> _favoriteProducts = [];

  List<Product> get favoriteProducts => _favoriteProducts;

  void addToFavorites(Product product) {
    _favoriteProducts.add(product);
    notifyListeners();
  }

  void removeFromFavorites(Product product) {
    _favoriteProducts.remove(product);
    notifyListeners();
  }

  bool isFavorite(Product product) {
    return _favoriteProducts.contains(product);
  }
}
