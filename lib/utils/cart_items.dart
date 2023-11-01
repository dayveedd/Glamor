class CartItem {
  final String image;
  final String productName;
  final String price;
  int count;

  CartItem(
      {required this.image,
      required this.productName,
      required this.price,
      this.count = 1});
}
