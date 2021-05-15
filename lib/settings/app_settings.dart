import 'package:flutter/material.dart';
import 'package:liquify/services/database_manager.dart';


final kMainColor1 = Color(0xFF0066FF);
final kMainColor2 = Color(0xFF1975FF);
final kMainColor3 = Color(0xFF4D94FF);
final kExtraColor1 = Color(0xFF003380);
final kExtraColor2 = Color(0xFF264A80);
final kExtraColor3 = Color(0xCC0052CC);
final kDarkColor1 = Color(0xFF212121);
final kDarkColor2 = Color(0xFF262626);
final kLightColor1 = Color(0xFF6E6E6E);
final kLightColor2 = Color(0xFFD9D9D9);
final kGreyColor1 = Color(0xFF696969);
final kGreyColor2 = Color(0xFFA5A5A5);

final kDefaultBoxDecoration = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final kDefaultGradient = LinearGradient(
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  colors: [kMainColor1, kMainColor3],
);

final kGreyGradient = LinearGradient(
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  colors: [
    kGreyColor1, kGreyColor2
  ]
);

final kDarkGradient = LinearGradient(
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  colors: [kDarkColor1, kDarkColor2],
);

final kLightGradient = LinearGradient(
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
  colors: [kLightColor1, kLightColor2],
);

final _darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: kMainColor1,
  brightness: Brightness.dark,
  backgroundColor: kDarkColor2,
  scaffoldBackgroundColor: kDarkColor2,
  accentColor: kLightColor2,
  dividerTheme: DividerThemeData(
    color: Colors.black12,
    indent: 16,
    endIndent: 16,
    thickness: 2
  ),
  textTheme: TextTheme(
    headline1: TextStyle(
      color: kLightColor2,
      fontFamily: 'OpenSans',
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      color: kLightColor2,
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'OpenSans',
    ),
    button: TextStyle(
      fontSize: 12.0,
      color: kLightColor2,
      fontFamily: 'OpenSans',
    ),
    caption: TextStyle(
      color: Colors.white54,
      fontFamily: 'OpenSans',
    ),
  ),
);

final _lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: kMainColor1,
  brightness: Brightness.light,
  backgroundColor: kLightColor2,
  scaffoldBackgroundColor: kLightColor2,
  accentColor: Colors.black,
  dividerTheme: DividerThemeData(
    color: Colors.grey,
    indent: 16,
    endIndent: 16,
    thickness: 2
  ),
  textTheme: TextTheme(
    headline1: TextStyle(
      color: kLightColor2,
      fontFamily: 'OpenSans',
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      color: kLightColor2,
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'OpenSans',
    ),
    button: TextStyle(
      fontSize: 12.0,
      color: kLightColor2,
      fontFamily: 'OpenSans',
    ),
    caption: TextStyle(
      color: Colors.white54,
      fontFamily: 'OpenSans',
    ),
  ),
);


class AppSettings with ChangeNotifier {
  static final AppSettings _singleton = AppSettings._internal();
  factory AppSettings(bool darkModeOn) {
    darkModeOn ? _singleton._themeData = _darkTheme : _singleton._themeData = _lightTheme;
    _singleton._isDark = darkModeOn;
    return _singleton;
  }
  AppSettings._internal();

  ThemeData _themeData = _lightTheme;
  get themeData => _themeData;
  set themeData(ThemeData value) {
    _themeData = value;
    _themeData == _lightTheme ? _isDark = false : _isDark = true;
    _updateSettingsInDatabase();
    notifyListeners();
  }

  bool _isDark;
  get isDark => _isDark;
  set isDark(bool value) {
    _isDark = value;
    _isDark ? _themeData = _darkTheme : _themeData = _lightTheme;
    _updateSettingsInDatabase();
    notifyListeners();
  }

  void _updateSettingsInDatabase() {
    var db = DatabaseManager();
    db.updateInDatabase('Settings', {'darkModeOn' : _isDark ? 1 : 0});
  }
}