
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/category.dart';
import 'package:myapp/viewmodels/category_viewmodel.dart';
import 'package:myapp/viewmodels/product_viewmodel.dart';
import 'package:myapp/views/auth/login_screen.dart';
import 'package:myapp/views/cart/cart_screen.dart';
import 'package:myapp/views/products/product_card.dart';
import 'package:myapp/views/profile/profile_screen.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isFilterExpanded = false;

  @override
  void initState() {
    super.initState();
    final productViewModel = Provider.of<ProductViewModel>(context, listen: false);
    productViewModel.fetchProducts();
    Provider.of<CategoryViewModel>(context, listen: false).fetchCategories();

    _searchController.addListener(() {
      productViewModel.updateSearchQuery(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);
    final categoryViewModel = Provider.of<CategoryViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                return IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileScreen()),
                    );
                  },
                );
              } else {
                return TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: Text('Sign In', style: TextStyle(color: Theme.of(context).primaryColor)),
                );
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search products...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _isFilterExpanded = !isExpanded;
              });
            },
            children: [
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return const ListTile(
                    title: Text('Filters'),
                  );
                },
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      DropdownButton<String>(
                        value: productViewModel.selectedCategory,
                        hint: const Text('Select a category'),
                        isExpanded: true,
                        items: categoryViewModel.categories
                            .map((Category category) => DropdownMenuItem<String>(
                                  value: category.name,
                                  child: Text(category.name),
                                ))
                            .toList(),
                        onChanged: (String? newValue) {
                          productViewModel.updateCategory(newValue);
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text('Price Range'),
                      RangeSlider(
                        values: productViewModel.priceRange,
                        min: 0,
                        max: productViewModel.maxPrice,
                        divisions: productViewModel.maxPrice.toInt(),
                        labels: RangeLabels(
                          '\$${productViewModel.priceRange.start.round()}',
                          '\$${productViewModel.priceRange.end.round()}',
                        ),
                        onChanged: (RangeValues values) {
                          productViewModel.updatePriceRange(values);
                        },
                      ),
                    ],
                  ),
                ),
                isExpanded: _isFilterExpanded,
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              _searchController.clear();
              productViewModel.clearFilters();
            },
            child: const Text('Clear Filters'),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: productViewModel.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (context, index) {
                final product = productViewModel.products[index];
                return ProductCard(product: product);
              },
            ),
          ),
        ],
      ),
    );
  }
}
