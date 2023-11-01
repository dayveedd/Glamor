import 'package:ecommerce/utils/saved_utils/saved_items.dart';
import 'package:flutter/foundation.dart';


class SavedModel extends ChangeNotifier {
  List<SavedItem> savedItems = [];

  void addToSaved(SavedItem items) {
    savedItems.add(items);
    notifyListeners();
  }

  void removeFromSaved(SavedItem items) {
    savedItems.remove(items);
    notifyListeners();
  }
}
