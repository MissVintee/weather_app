import 'package:flutter/material.dart';
import 'weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ThemeData.dark(useMaterial3: true).colorScheme,
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      home: const WeatherScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}