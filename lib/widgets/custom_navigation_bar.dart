import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquify/models/home_model.dart';
import 'package:liquify/settings/app_settings.dart';
import 'package:provider/provider.dart';


class CustomNavigationBar extends StatelessWidget {
  CustomNavigationBar();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final buttonColor = Theme.of(context).scaffoldBackgroundColor;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: height * 0.12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            gradient: kDefaultGradient),
        ),
        Padding(
          padding: EdgeInsets.only(top: height * 0.028),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FlatButton(
                onPressed: () {
                  context.read<HomeModel>().currentIndex = 0;
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.home,
                      color: buttonColor,
                      size: 32.0
                    ),
                    Text(
                      'Главная',
                      style: TextStyle(
                        color: buttonColor,
                        fontFamily: 'OpenSans'
                      ),
                    )
                  ]
                )
              ),
              FlatButton(
                onPressed: () {
                  context.read<HomeModel>().currentIndex = 1;
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.settings,
                        color: buttonColor,
                        size: 32.0
                      ),
                      Text(
                        'Настройки',
                        style: TextStyle(
                          color: buttonColor,
                          fontFamily: 'OpenSans'
                        ),
                      )
                    ]
                )
              ),
            ],
          ),
        )
      ],
    );
  }
}
