import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquify/models/home_model.dart';
import 'package:liquify/pages/settings_page.dart';
import 'package:liquify/widgets/custom_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'main_page.dart';


/// Домашняя страница приложения
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Страницы приложения
  ///
  /// Это те страницы, которые выбираются в BottomNavigationBar
  List<Widget> _pages = [
    MainPage(),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeModel>(
      create: (_) => HomeModel(),
      child: Scaffold(
        bottomNavigationBar: CustomNavigationBar(),
        body: Consumer<HomeModel>(
          builder: (context, model, child) {
            // Достает индекс страницы из модели и отрисовывает соответствующую страницу
            return _pages[model.currentIndex];
          }
        )
      ),
    );
  }
}
