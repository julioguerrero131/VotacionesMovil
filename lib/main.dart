import 'package:flutter/material.dart';
import 'screens/new_password_page.dart';
import 'screens/login_page.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,

  initialRoute: '/',
  routes: {
    '/':(context) => LoginPage(),
    '/recover_account':(context) => LoginPage(),
    '/new_password': (context) => NewPasswordPage(),
  },

  theme: ThemeData(

    primaryColor: const Color(0xFF18599d), 

    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: Color(0xFF18599d)), 
      titleTextStyle: TextStyle(color: Color(0xFF18599d), fontSize: 20), 
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF18599d), // Color de fondo
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w100),
        padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 25),
      ),
    ),

    textTheme: const TextTheme(
      labelLarge: TextStyle(
        color: Color(0xFF18599d),
      ),
      labelSmall: TextStyle(
        color: Color(0xFF18599d),
      ),
      headlineSmall: TextStyle(
        color: Color(0xFF18599d), 
        fontWeight: FontWeight.w500,
      )
    ),

    scaffoldBackgroundColor: Colors.white,

    inputDecorationTheme: InputDecorationTheme(
      alignLabelWithHint: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(
          color: Color(0xFFe9e7ff),
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(
          color: Color(0xFFC3BDFF),
          width: 1.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(
          color: Color(0xFFe9e7ff),
          width: 1.0,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(
          color: Color(0xFFC3BDFF),
          width: 1.0,
        ),
      ),
    ),
  ),
));
