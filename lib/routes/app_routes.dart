import 'package:flutter/material.dart';
import 'package:votaciones_movil/screens/login_page.dart';
import 'package:votaciones_movil/screens/main_page.dart';
import 'package:votaciones_movil/screens/new_password_page.dart';
import 'package:votaciones_movil/screens/recover_account_page.dart';
import 'package:votaciones_movil/screens/recover_code_page.dart';
import 'package:votaciones_movil/screens/report_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String main = '/main';
  
  static const String recoverAccount = '/recover_account';
  static const String recoverCode = '/recover_code';
  static const String newPassword = '/new_password';

  static const String reportPresident = '/report-president'; 

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginPage(),
      recoverAccount: (context) => RecoverAccountPage(),
      recoverCode: (context) => RecoverCodePage(),
      newPassword: (context) => NewPasswordPage(),
      main: (context) => const MainPage(),
      reportPresident: (context) => const ReportPage(),
    };
  }
}
