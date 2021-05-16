import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:liquify/pages/home_page.dart';
import 'package:liquify/pages/login_page.dart';
import 'package:liquify/services/authentication.dart';
import 'package:liquify/services/database_manager.dart';
import 'package:liquify/services/firestore/firestore_drink_service.dart';
import 'package:liquify/services/firestore/firestore_user_service.dart';
import 'package:liquify/settings/app_settings.dart';
import 'package:liquify/settings/portrait_mode.dart';
import 'package:provider/provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  portraitModeOnly();
  DatabaseManager().openNewDatabase('app.db').then((db) {
    DatabaseManager().getSettingsFromDatabase().then((settings) async {
      await Firebase.initializeApp();
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AppSettings>(
              create: (_) {
                return AppSettings(settings['darkModeOn'] == 1 ? true : false);
              }
            ),
            Provider<AuthenticationService>(
              create: (_) => AuthenticationService(FirebaseAuth.instance),
            ),
            // ignore: missing_required_param
            StreamProvider<User>(
              create: (context) => context.read<AuthenticationService>().authStateChanges,
            ),
            // ignore: missing_required_param
            StreamProvider<DocumentSnapshot>(
              create: (_) => FirestoreUserService.getUserStream(),
            ),
            // ignore: missing_required_param
            StreamProvider<QuerySnapshot>(
              create: (_) => FirestoreDrinkService.getDrinksStream(DateTime.now()),
            ),
          ],
          child: App()
        )
      );
    });
  });
}


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liquify',
      debugShowCheckedModeBanner: false,
      theme: context.watch<AppSettings>().themeData,
      home: AuthenticationWrapper(),
    );
  }
}


class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      FirestoreUserService.checkAndCreateUser();
      return HomePage();
    }
    return LoginPage();
  }
}
