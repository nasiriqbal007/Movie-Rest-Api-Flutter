import 'package:flutter/material.dart';

class PageProvider with ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void updatePage(int page) {
    _currentPage = page;
    notifyListeners();
  }
}
