import 'package:flutter/material.dart';
import 'package:tradeprinting_dsm51_equipo1/auth/auth.dart';
import 'package:tradeprinting_dsm51_equipo1/login_admin/root_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Productos',
      theme: ThemeData(
        //brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: RootPage(
        auth: Auth(),
      ),
    );
  }
}
