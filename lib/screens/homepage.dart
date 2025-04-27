import 'package:flutter/material.dart';
import 'parking_layout_N.dart';
import 'dummy_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Parking Finder App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select a Parking Lot:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ParkingLotNLayout(),
                  ),
                );
              },
              child: const Text('Parking Lot "N"'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => dummyLayout(),
                  ),
                );
              },
              child: const Text('Dummy Parking Lot 1'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => dummyLayout(),
                  ),
                );
              },
              child: const Text('Dummy Parking Lot 2'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => dummyLayout(),
                  ),
                );
              },
              child: const Text('Dummy Parking Lot 3'),
            )
          ],
        ),
      ),
    );
  }
}
