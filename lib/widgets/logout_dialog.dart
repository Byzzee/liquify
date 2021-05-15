import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquify/services/authentication.dart';
import 'package:provider/provider.dart';
import '../main.dart';


class LogoutDialog extends StatefulWidget {
  /// Диалоговое окно выхода из аккаунта
  const LogoutDialog(this.size, {Key key}) : super(key: key);
  /// Размеры экрана смартфона
  final Size size;

  @override
  _LogoutDialogState createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(0.0),
      backgroundColor: Colors.transparent,
      child: Container(
        width: widget.size.width * 0.4,
        height: widget.size.height * 0.16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32.0),
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              const Color(0xFFA02619),
              const Color(0xFFE33320)
            ]
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(widget.size.height * 0.005),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(widget.size.height * 0.01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(widget.size.height * 0.01),
                    child: Text(
                      'Выйти из аккаунта',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'OpenSans',
                        fontSize: 22.0
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // ignore: deprecated_member_use
                      FlatButton(
                        onPressed: () => Navigator.pop(context),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Text(
                          'Отмена',
                          style: TextStyle(
                            color: Colors.white54,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans',
                            fontSize: 16.0
                          ),
                        )
                      ),
                      // ignore: deprecated_member_use
                      FlatButton(
                        onPressed: () {
                          context.read<AuthenticationService>().signOut();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => AuthenticationWrapper()),
                            (route) => false
                          );
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Text(
                          'Выйти',
                          style: TextStyle(
                            color: const Color(0xFFE33320),
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
      ),
    );
  }
}
