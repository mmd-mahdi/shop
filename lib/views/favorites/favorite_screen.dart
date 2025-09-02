
import 'package:flutter/material.dart';
import 'package:myapp/viewmodels/favorite_viewmodel.dart';
import 'package:myapp/views/products/product_card.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteViewModel = Provider.of<FavoriteViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: favoriteViewModel.favoriteProducts.isEmpty
          ? const Center(
              child: Text('You have no favorite products yet.'),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: favoriteViewModel.favoriteProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemBuilder: (context, index) {
                final product = favoriteViewModel.favoriteProducts[index];
                return ProductCard(product: product);
              },
            ),
    );
  }
}
