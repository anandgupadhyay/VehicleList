import 'package:flutter/material.dart';
import 'package:vehiclelist/cars_list.dart';
import 'package:vehiclelist/show_cars_list_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"Prerna's Practical",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.purple
      ),
      home: CarTableScreen(cars:cars)
    );
  }
}
