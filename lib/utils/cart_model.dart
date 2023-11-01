import 'package:flutter/foundation.dart';

import 'cart_items.dart';

class CartModel extends ChangeNotifier {
  List<CartItem> cartItems = [];

  void addToCart(CartItem item) {
   if(!cartItems.any((existingItem) => existingItem.productName == item.productName)){
     cartItems.add(item);
     notifyListeners();
   }
  }

  void removeFromCart(CartItem item) {
    cartItems.remove(item);
    notifyListeners();
  }
}
