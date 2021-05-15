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
    //TODO: График по выпитым напиткам
    final _size = MediaQuery.of(context).size;

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
                  value: 0.5,
                ),
              ),
              Positioned(
                top: _size.height * 0.7,
                width: _size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '0Л · 0%',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: kExtraColor3,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'Осталось: 1,93Л',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: kExtraColor3,
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
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
                            message: 'Эта кнопка абсолютно ничего не делает. Нет смысла нажимать на неё!',
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
                        //TODO: Диалоговое окно быстрого добавления напитка
                        showDialog(context: context, builder: (context) {
                          return QuickAddDialog(size: _size);
                        });
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
