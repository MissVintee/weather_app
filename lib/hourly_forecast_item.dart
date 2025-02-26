import 'package:flutter/material.dart';

class HourlyForcastCard extends StatelessWidget {
  const HourlyForcastCard({super.key});

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
              'time',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            Icon(Icons.cloud, size: 40),
            Text(
              'tempe',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}