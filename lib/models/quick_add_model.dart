import 'package:flutter/cupertino.dart';

/// Модель для [QuickAddDialog]
class QuickAddModel with ChangeNotifier {
  /// Контроллер ввода для объёма выпитой жидеости
  final TextEditingController bulkController = TextEditingController();

  bool _addButtonEnabled = false;
  /// Активна ли кнопка добавления
  bool get addButtonEnabled => _addButtonEnabled;
  /// Активна ли кнопка добавления
  set addButtonEnabled(bool value) {
    _addButtonEnabled = value;
    notifyListeners();
  }
}