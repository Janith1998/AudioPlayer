import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


@override
Widget build(BuildContext context) {
  return GetMaterialApp(
    home: const Home(),
    debugShowCheckedModeBanner: false,
    title: "Beats",
    theme: ThemeData(
      fontFamily: "regular",
      appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),     
    ),
  );
}

}
