
import 'package:flutter/material.dart';
import 'package:myapp/viewmodels/category_viewmodel.dart';
import 'package:myapp/views/products/products_by_category_screen.dart';
import 'package:provider/provider.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CategoryViewModel>(context, listen: false).fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    final categoryViewModel = Provider.of<CategoryViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: ListView.builder(
        itemCount: categoryViewModel.categories.length,
        itemBuilder: (context, index) {
          final category = categoryViewModel.categories[index];
          return ListTile(
            title: Text(category.name),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductsByCategoryScreen(
                    category: category.name,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
