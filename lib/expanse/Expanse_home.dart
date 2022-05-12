import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_project/expanse/Expanse_Expenditure.dart';
import 'package:personal_project/expanse/Expense_Income.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_project/expanse/var/var.dart';
import 'package:personal_project/expanse/var/balance.dart';
import '../login.dart';

class Expanse extends StatefulWidget {
  const Expanse({Key? key}) : super(key: key);

  @override
  State<Expanse> createState() => _ExpanseState();
}

class _ExpanseState extends State<Expanse> {

  final String? kYellowColor = "lol";
  final String? pColor="nothing";

  // Fetch content from the json file

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.deepPurple.shade200,
          title: const Text(
            'For You',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: SingleChildScrollView(
      child:Container(child:
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child:balance(),
                      ),
                      Column(
                          children:[
                            Padding(
                                padding: const EdgeInsets.all(12),
                                child: Container(
                                    height: 175,
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(6),
                                            child: SizedBox(
                                                width: 170.0,
                                                height: 175.0,
                                                child: Card(
                                                  elevation: 2,
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(20),

                                                    child: InkWell(
                                                      onTap: () => Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => const Income()),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          RichText(
                                                              text: const TextSpan(
                                                                children: [
                                                                  WidgetSpan(
                                                                    child: Center(
                                                                        child:FaIcon(
                                                                          FontAwesomeIcons.plus,
                                                                          color: Colors.deepPurpleAccent,
                                                                          size: 30,
                                                                        )),),
                                                                ],
                                                              )),
                                                          const Divider(
                                                            thickness: 1,
                                                          ),
                                                          const SizedBox(height: 10),
                                                          Center(
                                                            child:RichText(
                                                              text: const TextSpan(
                                                                  text: 'INCOME',
                                                                  style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 19,
                                                                  )),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ), //Center
                                                  ),
                                                ) //Card
                                            ),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(6),
                                            child: SizedBox(
                                                width: 170.0,
                                                height: 175.0,
                                                child: Card(
                                                  elevation: 2,
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(20),

                                                    child: InkWell(
                                                      onTap: () => Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => const Expenditure()),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          RichText(
                                                              text: const TextSpan(
                                                                children: [
                                                                  WidgetSpan(
                                                                    child: Center(
                                                                        child:FaIcon(
                                                                          FontAwesomeIcons.minus,
                                                                          color: Colors.deepPurpleAccent,
                                                                          size: 30,
                                                                        )),),
                                                                ],
                                                              )),
                                                          const Divider(
                                                            thickness: 1,
                                                          ),
                                                          SizedBox(height: 10),
                                                          Center(
                                                            child:RichText(
                                                              text: const TextSpan(
                                                                  text: 'EXPENSE',
                                                                  style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 19,
                                                                  )),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ), //Center
                                                  ),
                                                ) //Card
                                            ),
                                          ),
                                        ]))),
                            Padding(padding: EdgeInsets.all(12),

                              child: buildDoctorList(),
                            ),
                          ]
                      )

                    ])


      )),);
  }


}

//Costom CLipper class with Path
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(
        0, size.height); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
    Offset(size.width - (size.width / 3.24), size.height - 105);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(
        size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}