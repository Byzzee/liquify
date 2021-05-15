import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquify/settings/app_settings.dart';

class Calendar extends StatelessWidget {
  Calendar({@required this.dateTime, @required this.size});

  final DateTime dateTime;
  final Size size;

  @override
  Widget build(BuildContext context) {
    String weekDay;
    switch (dateTime.weekday) {
      case 1:
        weekDay = 'Понедельник';
        break;
      case 2:
        weekDay = 'Вторник';
        break;
      case 3:
        weekDay = 'Среда';
        break;
      case 4:
        weekDay = 'Четверг';
        break;
      case 5:
        weekDay = 'Пятница';
        break;
      case 6:
        weekDay = 'Суббота';
        break;
      case 7:
        weekDay = 'Воскресенье';
        break;
      default:
        weekDay = 'Ошибка';
    }

    String month;
    switch (dateTime.month) {
      case 1:
        month = 'Январь';
        break;
      case 2:
        month = 'Февраль';
        break;
      case 3:
        month = 'Март';
        break;
      case 4:
        month = 'Апрель';
        break;
      case 5:
        month = 'Май';
        break;
      case 6:
        month = 'Июнь';
        break;
      case 7:
        month = 'Июль';
        break;
      case 8:
        month = 'Август';
        break;
      case 9:
        month = 'Сентябрь';
        break;
      case 10:
        month = 'Октябрь';
        break;
      case 11:
        month = 'Ноябрь';
        break;
      case 12:
        month = 'Декабрь';
        break;
      default:
        month = 'Ошибка';
    }

    return Container(
      height: size.height * 0.6,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.black38,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: size.height * 0.46,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${dateTime.day}',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text(
                    '$month',
                    style: Theme.of(context).textTheme.button,
                  )
                ],
              ),
            ),
          ),
          Container(
            height: size.height * 0.14,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
              gradient: kDefaultGradient
            ),
            child: Center(
                child: Text(
                  '$weekDay',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Theme.of(context).backgroundColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                )
            ),
          )
        ],
      ),
    );
  }
}
