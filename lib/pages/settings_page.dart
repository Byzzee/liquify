import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquify/settings/app_settings.dart';
import 'package:liquify/widgets/logout_dialog.dart';
import 'package:liquify/widgets/profile_card.dart';
import 'package:liquify/widgets/settings_item.dart';
import 'package:liquify/widgets/update_water_norm_dialog.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    bool _isDark = context.read<AppSettings>().isDark;
    Size _size = MediaQuery.of(context).size;
    int _waterNorm = context.watch<DocumentSnapshot>() != null
        ? context.watch<DocumentSnapshot>().data()['waterNorm']
        : 0;

    return SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: _size.height * 0.025,
          width: double.infinity,
        ),
        ProfileCard(
          size: _size,
          login: '${context.watch<User>().displayName}',
          email: '${context.watch<User>().email}',
          daily: _waterNorm,
          // ignore: deprecated_member_use
          logoutButton: FlatButton(
            onPressed: () {
              showDialog(context: context, builder: (context) => LogoutDialog(_size));
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            padding: EdgeInsets.all(0.0),
            height: _size.height * 0.01,
            child: Text(
              'Выйти из аккаунта',
              style: TextStyle(
                color: Colors.red,
                fontFamily: 'OpenSans'
              )
            )
          )
        ),
        SizedBox(
          height: _size.height * 0.05,
          width: double.infinity,
        ),
        SettingsItem(
          size: _size,
          icon: Icons.palette,
          title: 'Тёмная тема',
          trailing: Switch(
            value: _isDark,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (value) async {
              _isDark = value;
              context.read<AppSettings>().isDark = _isDark;
            },
          )
        ),
        SizedBox(
          height: _size.height * 0.025,
          width: double.infinity,
        ),
        SettingsItem(
          size: _size,
          icon: FontAwesomeIcons.tint,
          title: 'Изменить дневную цель',
          trailing: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return UpdateWaterNormDialog(size: _size);
                }
              );
            },
            icon: Icon(
              FontAwesomeIcons.arrowAltCircleRight,
              color: kLightColor2,
            ),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
        ),
        SizedBox(
          height: _size.height * 0.025,
          width: double.infinity,
        ),
        SettingsItem(
          size: _size,
          icon: FontAwesomeIcons.github,
          title: 'GitHub',
          trailing: IconButton(
            onPressed: () {
              openGitHub().then((value) {
                if (value == false) {
                  showTopSnackBar(
                    context,
                    CustomSnackBar.error(
                      message: 'Не удалось открыть страницу',
                      textStyle: TextStyle(
                        color: const Color(0xFF810000),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                        fontSize: 14.0
                      ),
                    )
                  );
                }
              });
            },
            icon: Icon(
              FontAwesomeIcons.externalLinkAlt,
              color: kLightColor2,
              size: 20.0,
            ),
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          )
        ),
      ]),
    );
  }
}
