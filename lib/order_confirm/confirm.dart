import 'package:flutter/material.dart';

class ConfirmPage extends StatelessWidget {
  final DateTime selectedDate;
  final String selectedTime;
  const ConfirmPage({
    Key? key,
    required this.selectedDate,
    required this.selectedTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(width: 0.5),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/success_icon.png',
                    height: 100,
                    width: 100,
                    // adjust the height and width as needed
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Lab tests have been scheduled successfully. '
                    'You will receive a mail of the same.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${selectedDate.day} ${_getMonth(selectedDate.month)} ${selectedDate.year} | $selectedTime',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 300,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the home screen
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                child: const Text('Back to Home'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonth(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }
}
