
import 'package:flutter/material.dart';
import 'package:myapp/viewmodels/cart_viewmodel.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.remove_shopping_cart),
            onPressed: () {
              cartViewModel.clearCart();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cartViewModel.cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = cartViewModel.cartItems[index];
          return Dismissible(
            key: Key(cartItem.product.id.toString()),
            onDismissed: (direction) {
              cartViewModel.removeFromCart(cartItem);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${cartItem.product.title} removed from cart'),
                ),
              );
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: ListTile(
              leading: Image.network(cartItem.product.thumbnail),
              title: Text(cartItem.product.title),
              subtitle: Text(
                  '\$${cartItem.product.price.toStringAsFixed(2)} x ${cartItem.quantity}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => cartViewModel.decreaseQuantity(cartItem),
                  ),
                  Text(cartItem.quantity.toString()),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => cartViewModel.increaseQuantity(cartItem),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${cartViewModel.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
