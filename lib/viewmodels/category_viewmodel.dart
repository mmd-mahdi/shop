
import 'package:flutter/material.dart';
import 'package:myapp/models/category.dart';
import 'package:myapp/services/api_service.dart';

class CategoryViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  Future<void> fetchCategories() async {
    try {
      final data = await _apiService.get('products/categories');
      _categories = (data as List)
          .map((json) => Category.fromJson(json))
          .toList();
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}
