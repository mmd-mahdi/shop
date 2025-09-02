
import 'package:flutter/material.dart';
import 'package:myapp/viewmodels/product_viewmodel.dart';
import 'package:myapp/views/products/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductsByCategoryScreen extends StatefulWidget {
  final String category;

  const ProductsByCategoryScreen({super.key, required this.category});

  @override
  State<ProductsByCategoryScreen> createState() =>
      _ProductsByCategoryScreenState();
}

class _ProductsByCategoryScreenState extends State<ProductsByCategoryScreen> {
  @override
  void initState() {
    super.initState();
    // Corrected to use the fetchProducts method with the category parameter
    Provider.of<ProductViewModel>(context, listen: false)
        .fetchProducts(category: widget.category);
  }

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: productViewModel.products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: productViewModel.products.length,
              itemBuilder: (context, index) {
                final product = productViewModel.products[index];
                return ListTile(
                  leading: Image.network(product.thumbnail),
                  title: Text(product.title),
                  subtitle: Text('\$${product.price}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailScreen(product: product),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
