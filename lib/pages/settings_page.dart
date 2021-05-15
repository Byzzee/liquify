import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquify/settings/app_settings.dart';
import 'package:liquify/widgets/logout_dialog.dart';
import 'package:liquify/widgets/profile_card.dart';
import 'package:liquify/widgets/settings_item.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    bool _isDark = context.read<AppSettings>().isDark;
    Size _size = MediaQuery.of(context).size;

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
          daily: 1.93,
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
      ]),
    );
  }
}
