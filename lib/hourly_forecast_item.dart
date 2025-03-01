import 'package:flutter/material.dart';

class HourlyForcastCard extends StatelessWidget {

  final String time;
  final IconData icon;
  final String temperature;

  const HourlyForcastCard({
    super.key,
    required this.time,
    required this.icon,
    required this.temperature,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: const Color.fromARGB(50, 255, 255, 255),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              time,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            Icon(icon, size: 40),
            Text(
              temperature,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}