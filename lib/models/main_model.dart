import 'package:flutter/cupertino.dart';

/// Модель для [MainPage]
class MainModel with ChangeNotifier {
  DateTime _dateTime = DateTime.now();
  /// Дата/время в настоящий момент времени
  DateTime get dateTime => _dateTime;
}