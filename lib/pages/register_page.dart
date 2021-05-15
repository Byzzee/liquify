import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:liquify/main.dart';
import 'package:liquify/services/authentication.dart';
import 'package:liquify/settings/app_settings.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    Widget emailTF() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: width * 0.02),
            child: Text(
              'Эл. почта',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          SizedBox(height: height * 0.01),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kDefaultBoxDecoration,
            height: height * 0.08,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              style: TextStyle(
                color: kLightColor2,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: height * 0.018),
                prefixIcon: Icon(
                  Icons.email_rounded,
                  color: kLightColor2,
                ),
                hintText: 'Введите свою эл. почту',
                hintStyle: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
        ],
      );
    }

    Widget nicknameTF() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: width * 0.02),
            child: Text(
              'Никнейм',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          SizedBox(height: height * 0.01),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kDefaultBoxDecoration,
            height: height * 0.08,
            child: TextField(
              keyboardType: TextInputType.name,
              controller: _nicknameController,
              style: TextStyle(
                color: kLightColor2,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: height * 0.018),
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: kLightColor2,
                ),
                hintText: 'Введите никнейм',
                hintStyle: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
        ],
      );
    }

    Widget passwordTF() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: width * 0.02),
            child: Text(
              'Пароль',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          SizedBox(height: height * 0.01),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kDefaultBoxDecoration,
            height: height * 0.08,
            child: TextField(
              obscureText: true,
              controller: _passwordController,
              style: TextStyle(
                color: kLightColor2,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: height * 0.018),
                prefixIcon: Icon(
                  Icons.lock,
                  color: kLightColor2,
                ),
                hintText: 'Введите пароль',
                hintStyle: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
        ],
      );
    }

    Widget loginBtn()  {
      return Container(
        alignment: Alignment.centerRight,
        child: FlatButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => AuthenticationWrapper()
            ));
          },
          padding: EdgeInsets.symmetric(horizontal: width * 0.02),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Text(
            'Войти',
            style: Theme.of(context).textTheme.button,
          ),
        ),
      );
    }

    Widget registerBtn(BuildContext ctx) {
      return GradientButton(
        callback: () {
          var rawResponse = context.read<AuthenticationService>().signUp(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            nickname: _nicknameController.text.trim()
          );
          rawResponse.then((responseMessage) {
            if (responseMessage != 'Signed up') {
              showTopSnackBar(
                context,
                CustomSnackBar.error(
                  message: '$responseMessage',
                  textStyle: TextStyle(
                    color: const Color(0xFF810000),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                    fontSize: 14.0
                  ),
                )
              );
            }
            else {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => AuthenticationWrapper()
              ));
            }
          });
        },
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            kLightColor2,
            Colors.white
          ]
        ),
        increaseWidthBy: width,
        increaseHeightBy: height * 0.02,
        child: Text(
          'Зарегистрироваться',
          style: TextStyle(
            color: kExtraColor1,
            letterSpacing: 2,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      );
    }


    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: kDefaultGradient
            ),
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.1,
              ),
              child: Builder(
                builder: (context) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Регистрация',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(height: height * 0.04),
                      emailTF(),
                      SizedBox(height: height * 0.04),
                      nicknameTF(),
                      SizedBox(height: height * 0.04),
                      passwordTF(),
                      SizedBox(height: height * 0.005),
                      loginBtn(),
                      SizedBox(height: height * 0.04),
                      registerBtn(context)
                    ],
                  );
                },
              )
            ),
          ),
        ],
      ),
    );
  }
}
