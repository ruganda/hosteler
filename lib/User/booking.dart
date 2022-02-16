import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hostels/components/RoundedInputField.dart';
import 'package:flutterwave/flutterwave.dart';
import 'package:hostels/components/palette.dart';
import 'package:hostels/user/payents.dart';

class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  var status = false;
  void initState() {
    super.initState();
    // pending();
  }

  TextEditingController bookDate = new TextEditingController(),
      bookTime = new TextEditingController();
  late String _hour, _minute, _time;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(const Duration(days: 20))))) {
      return true;
    }
    return false;
  }

  List<dynamic> bookDetails = [];

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      selectableDayPredicate: _decideWhichDayToEnable,
      helpText: 'CHOOSE BOOKING DATE',
      cancelText: 'NOT NOW',
      confirmText: 'SET',
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        bookDate.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      helpText: 'CHOOSE BOOKING TIME',
      cancelText: 'NOT NOW',
      confirmText: 'SET',
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString().length == 1
            ? '0' + selectedTime.hour.toString()
            : selectedTime.hour.toString();

        _minute = selectedTime.minute.toString().length == 1
            ? '0' + selectedTime.minute.toString()
            : selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        bookTime.text = _time;
      });
  }
  //booking session

  createAlert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Booking session"),
            content: StatefulBuilder(builder: (context, _) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RoundedInputField(
                      hintText: "Booking Date",
                      x: true,
                      icon: Icons.calendar_today_outlined,
                      tap: () {
                        _selectDate(context);
                      },
                      field: bookDate,
                    ),
                    RoundedInputField(
                      hintText: "Booking Time",
                      x: true,
                      icon: Icons.timelapse_outlined,
                      tap: () {
                        _selectTime(context);
                      },
                      field: bookTime,
                    ),
                  ],
                ),
              );
            }),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    var data = {'time': bookTime.text, 'date': bookDate.text};
                    setState(() {
                      bookDetails.add(data);
                    });
                    pending();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Book"))
            ],
          );
        });
  }

  Future<void> pending() async {
    Timer(const Duration(seconds: 10), () {
      setState(() {
        status = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fontsColor,
        title: const Text("Book History"),
        centerTitle: true,
      ),
      body: bookDetails.length < 1
          ? const Center(
              child: const Text("You current have no bookings"),
            )
          : ListView(
              children: List.generate(
                  bookDetails.length,
                  (index) => ListTile(
                        leading: const Icon(Icons.book_online_rounded),
                        title: Text("Time: " + bookDetails[index]['time']),
                        subtitle: Text("Date: " + bookDetails[index]['date']),
                        trailing: Chip(
                          avatar: Icon(
                            status
                                ? Icons.verified_rounded
                                : Icons.pending_actions_rounded,
                            color: Colors.white,
                            size: 19,
                          ),
                          label: Text(
                            status == true ? "Booked" : "Pending",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                            ),
                          ),
                          backgroundColor:
                              status == true ? Colors.green : Colors.red,
                        ),
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Payments(),
                              ),
                              (Route<dynamic> route) => true);
                        },
                      )),
            ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: fontsColor,
          child: const Icon(Icons.add),
          onPressed: () {
            createAlert(context);
          }),
    );
  }
}
