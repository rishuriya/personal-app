import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_project/expanse/Expanse_home.dart';
import 'package:personal_project/expanse/var/var.dart';

import '../login.dart';

class Expenditure extends StatefulWidget {
  const Expenditure({Key? key}) : super(key: key);

  @override
  _ExpenditureState createState() => _ExpenditureState();
}

class _ExpenditureState extends State<Expenditure> {
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
  CollectionReference users = FirebaseFirestore.instance.collection("User").doc(user?.uid).collection("Transaction");
  String date=DateTime.now().toString().substring(5, 7);
  String year=DateTime.now().toString().substring(0, 4);
  late DateTime _selectedDate;
  int amount=0 ;
  String remark='';
  String dropdownvalue = '___Select Sink___';
  String mode='Cash';
  var items =  ["___Select Sink___","Food","Travel","Cloths","Medicine","Miscellaneous"];
  final _amount = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _amount.dispose();
    super.dispose();
  }


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
        child: FutureBuilder<DocumentSnapshot>(
    future: users.doc("amount").collection(year).doc(int.parse(date).toString()).get(),
    builder:
    (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    if (snapshot.hasError) {
    return const Center(
    child: CircularProgressIndicator(),
    );
    }

    if (snapshot.hasData && !snapshot.data!.exists) {
    return const Center(
    child: CircularProgressIndicator(),
    );
    }

    if (snapshot.connectionState == ConnectionState.done) {
    Map<String, dynamic> data = snapshot.data!.data() as Map<String,
    dynamic>;
    return Column(
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
                    in_bank=data["in_bank"];
                    income=data["income"];
                    in_hand=data["in_hand"];
                    expenditure=data["expenditure"];
                    print(in_bank);
                  });
                },

              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 16,right:16,),
              child: TextField(
                  controller: _amount,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    labelText: 'Amount',
                    hintText: 'Amount',
                  ),
                  onChanged: (value) => amount=int.parse(_amount.text)
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
        );

      }
      return const Center(
      child: Padding(
      padding:EdgeInsets.only(top:245),
      child:CircularProgressIndicator(),
      ));
      }),),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          int i=token.length;
          print(i);
          if(i!=0) {
            token.removeRange(0, i - 1);
          }

          if (mode == 'Upi') {
            in_bank = in_bank! - amount!;
            expenditure=expenditure!+amount!;
          }if (mode == 'Cash') {
            in_hand=in_hand!-amount!;
            expenditure=expenditure!+amount!;
          }

          DocumentReference ref= FirebaseFirestore.instance
              .collection('User').doc(user?.uid).collection('Transaction').doc("amount").collection(year).doc(int.parse(date).toString());
          ref.set({
            "in_bank":in_bank,
            "in_hand":in_hand,
            "income":income,
            "expenditure":expenditure
          });
          if(amount!=0 && remark!="" && dropdownvalue!='___Select Sink___') {
            String? uid = user?.uid;
            String? id = _selectedDate.toString()+DateTime.now().toString();
            DocumentReference ref = FirebaseFirestore.instance
                .collection('User').doc(uid).collection('Transaction').doc(id);
            ref.set({
              'Day': id.substring(0, 10),
              'Source': dropdownvalue,
              'Amount': amount,
              'Remark': remark,
              'Mode': mode,
              'type': 'EXPENDITURE',
            });
            final snackbar = SnackBar(
              content: const Text('Transaction Stored!'),
              action: SnackBarAction(
                label: 'OK',
                onPressed: () {
                  ScaffoldMessenger.of(context)
                      .hideCurrentSnackBar();
                  Navigator.pop(
                      context);
                },
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
            buildDoctorList();
          }else{
            final snackbar = SnackBar(
              content: const Text('All field are mandatory!'),
              action: SnackBarAction(
                label: 'OK',
                onPressed: () {
                  ScaffoldMessenger.of(context)
                      .hideCurrentSnackBar();
                },
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
          }

          print("refresh done ");

        },
        icon: const Icon(Icons.save),
        label: const Text("Save"),
      ),
    );
  }
}