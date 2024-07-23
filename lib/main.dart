import 'package:flutter/material.dart';
import 'help.dart';
import 'loginpage.dart';
import 'logo.dart';
import 'homescreen.dart';


main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LogoPage(),
        '/urlInput': (context) => UrlPage(),
         '/supportRequest': (context) => SupportRequestPage(),
         '/loginPage': (context) => LoginPage(),

      },
    );
  }
}


