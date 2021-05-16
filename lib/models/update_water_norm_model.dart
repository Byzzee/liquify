import 'package:flutter/cupertino.dart';

/// Модель для [UpdateWaterNormDialog]
class UpdateWaterNormModel with ChangeNotifier {
  /// Контроллер ввода для объёма выпитой жидкости
  final TextEditingController bulkController = TextEditingController();

  bool _updateButtonEnabled = false;
  /// Активна ли кнопка обновления
  bool get updateButtonEnabled => _updateButtonEnabled;
  /// Активна ли кнопка обновления
  set updateButtonEnabled(bool value) {
    _updateButtonEnabled = value;
    notifyListeners();
  }
}