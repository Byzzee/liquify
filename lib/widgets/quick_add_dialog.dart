import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquify/models/quick_add_model.dart';
import 'package:liquify/settings/app_settings.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


class QuickAddDialog extends StatefulWidget {
  QuickAddDialog({@required this.size});
  final Size size;

  @override
  _QuickAddDialogState createState() => _QuickAddDialogState();
}

class _QuickAddDialogState extends State<QuickAddDialog> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<QuickAddModel>(
      create: (_) => QuickAddModel(),
      // [Builder] - это костыль, чтобы [context] содержал [ChangeNotifierProvider<QuickAddModel>]
      child: Builder (
        builder: (context) => Dialog(
          insetPadding: const EdgeInsets.all(0.0),
          backgroundColor: Colors.transparent,
          child: Container(
            width: widget.size.width * 0.9,
            height: widget.size.height * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32.0),
              gradient: kDefaultGradient,
            ),
            child: Padding(
              padding: EdgeInsets.all(widget.size.height * 0.005),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.all(widget.size.height * 0.025),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // Заголовок
                        Padding(
                          padding: EdgeInsets.only(left: widget.size.width * 0.02, top: widget.size.height * 0.01),
                          child: Text(
                            'Объём',
                            style: TextStyle(
                              color: context.read<AppSettings>().isDark ? kLightColor2 : Colors.black54,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                        SizedBox(height: widget.size.height * 0.015),
                        // Само поле
                        Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6.0,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          height: widget.size.height * 0.075,
                          child: TextField(
                            onChanged: (value) {
                              // Если поле ввода пустое, отключает кнопку добавления
                              if (value != '') {
                                context.read<QuickAddModel>().addButtonEnabled = true;
                              }
                              else {
                                context.read<QuickAddModel>().addButtonEnabled = false;
                              }
                            },
                            keyboardType: TextInputType.number,
                            controller: context.read<QuickAddModel>().bulkController,
                            maxLength: 4,
                            style: TextStyle(
                              color: kLightColor2,
                              fontFamily: 'OpenSans',
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.local_drink_rounded,
                                color: kLightColor2,
                              ),
                              suffixText: 'мл     ',
                              counterText: '',
                              hintText: 'Введите объём',
                              hintStyle: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // ignore: deprecated_member_use
                        FlatButton(
                          onPressed: () => Navigator.pop(context),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Text(
                            'Отмена',
                            style: TextStyle(
                              color: context.read<AppSettings>().isDark ? Colors.white54 : Colors.black45,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                              fontSize: 16.0
                            ),
                          )
                        ),
                        // ignore: deprecated_member_use
                        FlatButton(
                          onPressed: () {
                            // TODO: Сделать кнопку небесполезной
                            if (context.read<QuickAddModel>().addButtonEnabled) {
                              showTopSnackBar(
                                context,
                                CustomSnackBar.success(
                                  message: 'Данные успешно добавлены',
                                  backgroundColor: kMainColor1,
                                  textStyle: TextStyle(
                                    color: kExtraColor1,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'OpenSans',
                                    fontSize: 18.0
                                  ),
                                )
                              );
                              Navigator.pop(context);
                            }
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: Text(
                            'Добавить',
                            style: TextStyle(
                              color: context.watch<QuickAddModel>().addButtonEnabled ? kMainColor1 : (context.read<AppSettings>().isDark ? Colors.white54 : Colors.black45),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                              fontSize: 16.0
                            ),
                          )
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      )
    );
  }
}
