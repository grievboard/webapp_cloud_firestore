import 'package:flutter/material.dart';
import 'useless_pages/login.dart';
import 'drag_try.dart';
import 'useless_pages/home_page/main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: IntroPage.id,
      routes: {
        IntroPage.id: (context) => IntroPage(),
        Login.id: (context) => Login(),
        DragTry.id: (context) => DragTry()
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
    );
  }
}
