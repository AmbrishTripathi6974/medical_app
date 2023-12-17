import 'package:flutter/material.dart';
import 'package:medical_test_app/order_confirm/confirm.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppointmentScreen extends StatefulWidget {
  const MyAppointmentScreen({Key? key}) : super(key: key);

  @override
  _MyAppointmentScreenState createState() => _MyAppointmentScreenState();
}

class _MyAppointmentScreenState extends State<MyAppointmentScreen> {
  late DateTime _selectedDate = DateTime.now();
  late String _selectedTime = '';
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedDate = prefs.getString('selectedDate');
    final savedTime = prefs.getString('selectedTime');

    setState(() {
      _selectedDate =
          savedDate != null ? DateTime.parse(savedDate) : DateTime.now();
      _selectedTime = savedTime ?? '';
      _isButtonEnabled = _selectedDate != Null && _selectedTime.isNotEmpty;
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedDate', _selectedDate.toString());
    prefs.setString('selectedTime', _selectedTime);
  }

  Future<void> _navigateToBookingPage() async {
    await _saveData(); // Save selected data before navigating to the booking page
    setState(() {
      _isButtonEnabled = true;
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Appointment Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Selected Date: $_selectedDate'),
                Text('Selected Time: $_selectedTime'),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ConfirmPage(
                    selectedDate: _selectedDate,
                    selectedTime: _selectedTime,
                  ),
                ));
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                print("back button clicked");
              },
            ),
            const Text('Book Appointment'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Select Date',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(width: 0.5),
                      ),
                      child: TableCalendar(
                        firstDay: DateTime.now(),
                        lastDay: DateTime.now().add(const Duration(days: 365)),
                        focusedDay: DateTime.now(),
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDate, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDate = selectedDay;
                            _isButtonEnabled = _selectedDate != Null &&
                                _selectedTime.isNotEmpty;
                            _saveData(); // Save selected date when changed
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Select Time',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: 18,
                itemBuilder: (context, index) {
                  String time =
                      '${(index + 6).toString().padLeft(2, '0')}:00 ${index < 12 ? 'AM' : 'PM'}';
                  bool isSelected = _selectedTime == time;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTime = time;
                        _isButtonEnabled =
                            _selectedDate != Null && _selectedTime.isNotEmpty;
                        _saveData(); // Save selected time when changed
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.5),
                        color: isSelected ? Colors.blue : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        time,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: _isButtonEnabled ? _navigateToBookingPage : null,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 35,
                    decoration: BoxDecoration(
                      color: _isButtonEnabled
                          ? Colors.blue
                          : Colors
                              .grey, // Change color based on the button state
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        _isButtonEnabled ? 'Confirm' : 'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
