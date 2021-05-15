import 'package:flutter/cupertino.dart';

/// Модель для [HomePage]
class HomeModel with ChangeNotifier {
  int _currentIndex = 0;
  /// Индекс активной (выбранной) страницы
  int get currentIndex => _currentIndex;
  /// Индекс активной (выбранной) страницы
  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }
}