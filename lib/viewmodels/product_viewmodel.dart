
import 'package:flutter/material.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/services/api_service.dart';

class ProductViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];

  // Filter states
  String _searchQuery = '';
  String? _selectedCategory;
  double _maxPrice = 2000;
  RangeValues _priceRange = const RangeValues(0, 2000);

  List<Product> get products => _filteredProducts;
  RangeValues get priceRange => _priceRange;
  double get maxPrice => _maxPrice;
  String? get selectedCategory => _selectedCategory;

  Future<void> fetchProducts({String? category}) async {
    try {
      String endpoint = 'products';
      if (category != null) {
        endpoint = 'products/category/$category';
      }
      final data = await _apiService.get(endpoint);
      _allProducts = (data['products'] as List)
          .map((json) => Product.fromJson(json))
          .toList();

      if (_allProducts.isNotEmpty) {
        _maxPrice = _allProducts
            .map((p) => p.price.toDouble())
            .reduce((a, b) => a > b ? a : b);
        _priceRange = RangeValues(0, _maxPrice);
      }

      _applyFilters();
    } catch (e) {
      // Handle error
    }
  }

  void _applyFilters() {
    _filteredProducts = _allProducts.where((product) {
      final categoryMatch = _selectedCategory == null ||
          _selectedCategory!.isEmpty ||
          product.category == _selectedCategory;

      final searchMatch = _searchQuery.isEmpty ||
          product.title.toLowerCase().contains(_searchQuery.toLowerCase());

      final priceMatch =
          product.price >= _priceRange.start && product.price <= _priceRange.end;

      return categoryMatch && searchMatch && priceMatch;
    }).toList();

    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void updateCategory(String? category) {
    _selectedCategory = category;
    _applyFilters();
  }

  void updatePriceRange(RangeValues range) {
    _priceRange = range;
    _applyFilters();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedCategory = null;
    _priceRange = RangeValues(0, _maxPrice);
    _applyFilters();
  }
}
