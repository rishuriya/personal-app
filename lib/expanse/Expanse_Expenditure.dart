import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_project/expanse/Expanse_home.dart';

class Expenditure extends StatefulWidget {
  const Expenditure({Key? key}) : super(key: key);

  @override
  _ExpenditureState createState() => _ExpenditureState();
}

class _ExpenditureState extends State<Expenditure> {
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  late DateTime _selectedDate;
  late String amount ;
  String remark='';
  String dropdownvalue = '___Select Sink___';
  String mode='';
  var items =  ["___Select Sink___","Food","Travel","Cloths","Medicine","Miscellaneous"];


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
          'ADD EXPENDITURE',
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
                          padding: const EdgeInsets.all(12),
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
            Padding(padding: const EdgeInsets.only(left:16,right:16),
              child:CustomRadioButton(
                buttonTextStyle: ButtonTextStyle(
                  selectedColor: Colors.white,
                  unSelectedColor: Colors.black,
                  textStyle: TextStyle(
                    fontSize: 16,
                  ),
                ),
                autoWidth: false,
                enableButtonWrap: true,
                wrapAlignment: WrapAlignment.center,
                unSelectedColor: Colors.transparent,
                buttonLables: const [
                  "CASH",
                  "UPI",
                ],
                buttonValues: const [
                  "Cash",
                  "Upi"
                ],
                radioButtonValue: (values) {
                  mode=values.toString();
                },
                defaultSelected: "Cash",
                horizontal: false,
                //width: 120,
                // hight: 50,
                selectedColor: Colors.deepPurpleAccent,
                padding: 5,
                enableShape: true,
              ),
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          String id=_selectedDate.toString();
          if(dropdownvalue!="Miscellaneous" || remark!='') {
            DocumentReference ref = FirebaseFirestore.instance
                .collection('Transaction').doc(id);
            ref.set({
              'Day': id.substring(0, 10),
              'Source': dropdownvalue,
              'Amount': amount,
              'Remark': remark,
              'Mode':mode,
              'type': 'EXPENDITURE',
            });
          }
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const Expanse()),
          );
          if (kDebugMode) {
            print(databaseReference);
          }
        },
        icon: const Icon(Icons.save),
        label: const Text("Save"),
      ),
    );
  }
}