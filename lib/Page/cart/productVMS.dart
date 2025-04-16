import 'package:flutter/material.dart';
import 'package:doanthuchanh/model/cart.dart';

class ProductsVM extends ChangeNotifier {
  List<Cart> _lst = [];

  List<Cart> get lst => _lst;

  void addProduct(Cart product) {
    _lst.add(product);
    notifyListeners(); // Thông báo khi danh sách sản phẩm thay đổi
  }

  void removeProduct(Cart product) {
    _lst.remove(product);
    notifyListeners(); // Thông báo khi danh sách sản phẩm thay đổi
  }

  void updateProduct(Cart product) {
    int index = _lst.indexWhere((p) => p.productID == product.productID);
    if (index != -1) {
      _lst[index] = product;
      notifyListeners(); // Thông báo khi sản phẩm được cập nhật
    }
  }

  int _itemCount = 0;

  int get itemCount => _itemCount;

  void setItemCount(int count) {
    _itemCount = count;
    notifyListeners();
  }

  void incrementItemCount() {
    _itemCount++;
    notifyListeners();
  }

  void decrementItemCount() {
    if (_itemCount > 0) {
      _itemCount--;
      notifyListeners();
    }
  }
}
