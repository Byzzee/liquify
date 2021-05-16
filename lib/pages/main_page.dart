import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:liquify/models/main_model.dart';
import 'package:liquify/settings/app_settings.dart';
import 'package:liquify/widgets/calendar.dart';
import 'package:liquify/widgets/quick_add_dialog.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    int _waterNorm = context.watch<DocumentSnapshot>() != null
        ? context.watch<DocumentSnapshot>().data()['waterNorm']
        : 0;
    int _totalDrinkAmount = 0;
    if (context.watch<QuerySnapshot>() != null) {
      for (var doc in context.watch<QuerySnapshot>().docs) {
        _totalDrinkAmount += doc['amount'];
      }
    }
    int _waterPercentage = (_totalDrinkAmount/_waterNorm*100).round();

    return ChangeNotifierProvider<MainModel>(
      create: (_) => MainModel(),
      builder: (context, child) {
        return SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                left: _size.width * 0.05,
                top: _size.height * 0.03,
                child: Calendar(
                  dateTime: context.read<MainModel>().dateTime,
                  size: _size * 0.25,
                ),
              ),
              Positioned(
                top: _size.height * 0.75,
                width: _size.width * 0.9,
                height: _size.height * 0.03,
                child: LiquidLinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(kMainColor3),
                  borderColor: kExtraColor3,
                  borderRadius: 32.0,
                  borderWidth: 1.0,
                  value: _waterPercentage / 100,
                ),
              ),
              Positioned(
                top: _size.height * 0.7,
                width: _size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$_totalDrinkAmount мл · $_waterPercentage%',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: kExtraColor3,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'Осталось: ${(_waterNorm - _totalDrinkAmount) < 0 ? 0 : (_waterNorm - _totalDrinkAmount)} мл',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: kExtraColor3,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                )
              ),
              Positioned(
                top: _size.height * 0.55,
                right: _size.width * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularGradientButton(
                      callback: () {
                        //TODO: Диалоговое окно детального добавления напитка
                        showTopSnackBar(
                          context,
                          CustomSnackBar.info(
                            message:
                              'Эта кнопка абсолютно ничего не делает. Нет смысла нажимать на неё!',
                            backgroundColor: const Color(0xFFDDC000),
                            textStyle: TextStyle(
                              color: const Color(0xFF6D5F00),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                              fontSize: 14.0
                            ),
                          )
                        );
                      },
                      gradient: kGreyGradient,
                      shadowColor: Colors.transparent,
                      child: Icon(
                        Icons.dehaze_rounded,
                        color: Theme.of(context).backgroundColor,
                      ),
                    ),
                    SizedBox(
                      width: _size.width * 0.05,
                    ),
                    GradientButton(
                      callback: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return QuickAddDialog(size: _size);
                          }
                        );
                      },
                      gradient: kDefaultGradient,
                      shadowColor: Colors.transparent,
                      increaseWidthBy: _size.width * 0.25,
                      increaseHeightBy: _size.height * 0.03,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Theme.of(context).backgroundColor,
                            size: 28.0,
                          ),
                          SizedBox(
                            width: _size.width * 0.02,
                          ),
                          Text(
                            'Добавить',
                            style: TextStyle(
                              color: Theme.of(context).backgroundColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                              fontSize: 16.0
                            ),
                          ),
                          SizedBox(
                            width: _size.width * 0.03,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
