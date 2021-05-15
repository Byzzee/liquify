import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:liquify/pages/register_page.dart';
import 'package:liquify/services/authentication.dart';
import 'package:liquify/settings/app_settings.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


/// Страница входа/логина приложения
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// Контроллер ввода для эл. почты
  final TextEditingController _emailController = TextEditingController();
  /// Контроллер ввода для пароля
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    /// Поле ввода эл. почты
    ///
    /// Состоит из заголовка и самого поля.
    Widget emailTF() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Заголовок
          Padding(
            padding: EdgeInsets.only(left: width * 0.02),
            child: Text(
              'Эл. почта',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          SizedBox(height: height * 0.01),
          // Само поле
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

    /// Поле ввода пароля
    Widget passwordTF() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Заголовок
          Padding(
            padding: EdgeInsets.only(left: width * 0.02),
            child: Text(
              'Пароль',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          // Само поле
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
                hintText: 'Введите свой пароль',
                hintStyle: Theme.of(context).textTheme.caption,
              ),
            ),
          ),
        ],
      );
    }

    /// Кнопка перехода на страницу регистрации
    Widget registerBtn() {
      return Container(
        alignment: Alignment.centerRight,
        child: FlatButton(
          onPressed: () {
            // Переводит на страницу регистрации
            // Используется *replacement*, чтобы нельзя было вернуться системной кнопкой "назад"
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => RegisterPage()
            ));
          },
          padding: EdgeInsets.symmetric(horizontal: width * 0.02),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Text(
            'Зарегистрироваться',
            style: Theme.of(context).textTheme.button,
          ),
        ),
      );
    }

    /// Кнопка входа/логина в приложение
    Widget loginBtn(BuildContext ctx) {
      return GradientButton(
        callback: () {
          // Текст ответа, полученного из [signIn]
          // Если входные данные верны, пользователя сразу логинит в приложение
          var rawResponse = context.read<AuthenticationService>().signIn(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
          // Если входные данные не верны, выводит текст ошибки
          rawResponse.then((responseMessage) {
            if (responseMessage != 'Signed in') {
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
          'ВОЙТИ',
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
                vertical: height * 0.2,
              ),
              child: Builder(
                builder: (context) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Вход',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SizedBox(height: height * 0.04),
                      emailTF(),
                      SizedBox(height: height * 0.04),
                      passwordTF(),
                      SizedBox(height: height * 0.005),
                      registerBtn(),
                      SizedBox(height: height * 0.04),
                      loginBtn(context)
                    ],
                  );
                }
              )
            ),
          ),
        ],
      ),
    );
  }
}
