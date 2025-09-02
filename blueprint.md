# Online Shop Flutter App

## Overview

This is a Flutter application for an online shop. It uses Firebase for authentication and displays a list of products from a dummy API. Users can view product details, add products to their cart, and search for products.

## Features Implemented

* **Modern UI Makeover:**
    * **Centralized Theme:** A new `app_theme.dart` file defines a consistent and modern color scheme, custom fonts, and component styles.
    * **`google_fonts` Integration:** The `lato` font has been integrated for a clean and readable typography.
    * **Redesigned Product Cards:** Product cards now feature a modern design with shadows, rounded corners, and improved typography.
    * **Larger Product Images:** Product images now fill the entire available space in the product card for a more visually appealing layout.
* **Firebase Authentication:** 
    * Users can log in with email and password.
    * **Dynamic Profile Button:** The app bar now displays a profile icon for logged-in users and a "Sign In" button for guests.
    * **Sign Out:** Users can sign out from their profile screen.
    * **Real-Time UI Updates:** The UI automatically updates based on the user's authentication state.
    * **Post-Authentication Redirect:** Users are automatically redirected to the product list page after a successful sign-in or sign-up.
    * **Automatic Sign-In on Sign-Up:** New users are automatically signed in after creating an account.
    * **Improved Sign-In Button Visibility:** The "Sign In" button now has a contrasting color, making it easily visible on the app bar.
* **Tabbed Profile Screen:** The profile section is organized into three tabs:
    * **Favorites:** Users can view a list of their favorited items, accessed through their profile.
    * **Order History:** A dedicated screen to display the user's past orders.
    * **Personal Data:** Users can view and edit their personal information, including name, phone number, and address.
* **Product List:** The main screen of the application, displaying a list of products with their thumbnail, title, and price.
* **Product Detail:** Shows the details of a selected product, including images, description, and price.
* **Product Search:** Users can search for products by name.
* **Unified Filter Section:** 
    * A collapsible section that combines category and price filters for a cleaner UI.
    * **Category Filter:** Users can filter products by category.
    * **Price Filter:** Users can filter products by price using a range slider.
    * **Fixed Filter Expansion:** The filter section now expands and collapses correctly.
* **Advanced Shopping Cart:**
    * Users can add products to their shopping cart.
    * Users can view the items in the cart.
    * **Quantity Management:** Users can increase or decrease the quantity of each item in the cart.
    * **Remove Items:** Users can remove items from the cart by swiping them away.

## Next Steps

* Implement a checkout process.
* Populate the "Favorites" and "Order History" screens with dynamic data.
* Improve the UI/UX of the application.
* Add more error handling and user feedback.
