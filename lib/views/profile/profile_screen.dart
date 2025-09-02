
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/views/profile/favorites_screen.dart';
import 'package:myapp/views/profile/order_history_screen.dart';
import 'package:myapp/views/profile/personal_data_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pop(context);
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.favorite), text: 'Favorites'),
              Tab(icon: Icon(Icons.history), text: 'Order History'),
              Tab(icon: Icon(Icons.person), text: 'Personal Data'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            FavoritesScreen(),
            OrderHistoryScreen(),
            PersonalDataScreen(),
          ],
        ),
      ),
    );
  }
}
