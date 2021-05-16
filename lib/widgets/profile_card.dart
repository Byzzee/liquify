import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquify/settings/app_settings.dart';

class ProfileCard extends StatelessWidget {
  ProfileCard({@required this.size, @required this.login, @required this.email, @required this.daily, @required this.logoutButton});
  final Size size;
  final String login;
  final String email;
  final int daily;
  final Widget logoutButton;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: size.width * 0.9,
          height: size.height * 0.2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32.0),
            color: Colors.black38
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.02, horizontal: size.width * 0.05)/*EdgeInsets.only(left: size.width * 0.05, top: size.height * 0.02)*/,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$login',
                  style: Theme.of(context).textTheme.headline1,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                ),
                SizedBox(
                  height: size.height * 0.01,
                ),
                Text(
                  '$email',
                  style: Theme.of(context).textTheme.button,
                    overflow: TextOverflow.fade,
                    softWrap: false,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: logoutButton,
                )
              ],
            ),
          ),
        ),
        Container(
          width: size.width * 0.9,
          height: size.height * 0.04,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(32.0)),
            gradient: kDefaultGradient
          ),
          child: Center(
            child: Text(
              'Дневная цель: $daily мл',
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
    );
  }
}
