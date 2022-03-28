import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Income extends StatefulWidget {
  @override
  _IncomeState createState() => _IncomeState();
}

class _IncomeState extends State<Income> {
  late DateTime _selectedDate;
  late String amount ;
  String remark='';
  String dropdownvalue = '___Select Source___';

  var items =  ["___Select Source___","Home","Borrow","Awards","Family"];


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
      backgroundColor: Colors.deepPurple.shade50,
      extendBody: true,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                  width: 400.0,
                  height: 200.0,
                  child: Card(
                      elevation: 2,
                      shadowColor: Colors.black,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: InkWell(
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: CalendarTimeline(
                            showYears: true,
                            initialDate: _selectedDate,
                            firstDate:
                                DateTime.now().subtract(Duration(days: 7)),
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
                      ))),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16,right:16,),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                ),
                value: dropdownvalue,
                hint:const Text("Source"),
                icon: Icon(Icons.keyboard_arrow_down),

                items:items.map((String items) {
                  return DropdownMenuItem(
                      value: items,
                      child: Text(items)
                  );
                }
                ).toList(),
                onChanged: (newValue){
                  setState(() {
                    dropdownvalue = newValue.toString();
                  });
                },

              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16,right:16,),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  labelText: 'Amount',
                  hintText: 'Amount',
                ),
                onChanged: (value) => amount = value,
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16,right:16,),
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  labelText: 'Remark',
                  hintText: 'Remark',
                ),
                onChanged: (value) => remark = value,
              ),
            ),
            SizedBox(height: 20),
            Center(
                child: Text('Selected date is $_selectedDate',
                    style: TextStyle(color: Colors.black)))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => Income()));
      },
        icon: const Icon(Icons.save),
        label: const Text("Save"),
      ),
    );
  }
}