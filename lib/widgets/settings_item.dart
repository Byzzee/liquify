import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquify/settings/app_settings.dart';
import 'package:provider/provider.dart';

class SettingsItem extends StatefulWidget {
  SettingsItem({@required this.size, @required this.icon, @required this.title, @required this.trailing});
  final Size size;
  final IconData icon;
  final String title;
  final Widget trailing;

  @override
  _SettingsItemState createState() => _SettingsItemState();
}

class _SettingsItemState extends State<SettingsItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(32.0)
      ),
      height: widget.size.height * 0.08,
      width: widget.size.width * 0.9,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              color: kLightColor2
            ),
            Text(
              widget.title,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                color: kLightColor2
              ),
            ),
            widget.trailing
          ],
        ),
      )
    );
      /*ListTile(
      leading: Icon(widget.icon),
      title: Text(widget.title),
      trailing: widget.trailing,
    )*/
  }
}
