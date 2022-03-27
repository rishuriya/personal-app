import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Income extends StatefulWidget {
  @override
  _IncomeState createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'ADD INCOME',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.normal, fontSize: 25),
        ),

      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: 400.0,
                height: 200.0,
                child:Card(
                elevation: 2,
                shadowColor: Colors.black,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
            child:InkWell(
              child:Padding(
                padding: EdgeInsets.all(12),
            child:CalendarTimeline(
              showYears: true,
              initialDate: _selectedDate,
              firstDate: DateTime.now().subtract(Duration(days: 7)),
              lastDate: DateTime.now().add(Duration(days: 1095)),
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = date!;
                });
              },
              leftMargin: 0,
              monthColor: Colors.black87,
              dayColor: Colors.black,
              dayNameColor: Colors.white,
              activeDayColor: Colors.white,
              activeBackgroundDayColor: Colors.deepPurpleAccent,
              dotsColor: Colors.white,
              selectableDayPredicate: (date) => date.day != 23,
              locale: 'en',
            ),
              ),
            )
              )
            ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: TextButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal[200])),
                child: Text('RESET', style: TextStyle(color: Color(0xFF333A47))),
                onPressed: () => setState(() => _resetSelectedDate()),
              ),
            ),
            SizedBox(height: 20),
            Center(child: Text('Selected date is $_selectedDate', style: TextStyle(color: Colors.black)))
          ],
        ),
      ),
    );
  }
}