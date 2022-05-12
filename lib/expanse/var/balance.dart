import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Home.dart';
import '../../login.dart';

class Balance extends StatelessWidget {
  final int? in_bank;
  final int? in_hand;

  final int? income;
  final int? expenditure;

  Balance(this.in_bank,
      this.in_hand,
      this.income,
      this.expenditure,
      {Key? key}) : super(key: key);


  Widget _buildItemCard(
      {required String title,
        required String total,
        required Color color,
        required IconData icon,
        required GestureTapCallback onTap}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                          child: FaIcon(
                            icon,
                            color: color,
                            size: 30,
                          )),
                    ],
                  )),
              SizedBox(height: 25),
              RichText(
                  text: TextSpan(
                      text: title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                      ))),
              SizedBox(height: 10),
              Divider(
                thickness: 1,
              ),
              RichText(
                  text: TextSpan(
                      text: total,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                      ))),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child:Stack(
                children: [
                  //stack overlaps widgets
                  Opacity(
                    //semi red clippath with more height and with 0.5 opacity
                    opacity: 0.5,
                    child: ClipPath(
                      clipper: WaveClipper(), //set our custom wave clipper
                      child: Container(
                        color: Colors.deepPurple.shade400,
                        height: 350,
                      ),
                    ),
                  ),

                  ClipPath(
                    //upper clippath with less height

                    child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Container(
                          height: 250,
                          child: PageView(
                            controller: PageController(
                                viewportFraction: 0.5, initialPage: 1),
                            scrollDirection: Axis.horizontal,
                            pageSnapping: false,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 6, right: 6),
                                child: _buildItemCard(
                                    title: "Bank",
                                    total: "₹ ${in_bank.toString()}",
                                    color: Colors.blue,
                                    icon: FontAwesomeIcons.buildingColumns,
                                    onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Home()),
                                        )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 6, right: 6),
                                child: _buildItemCard(
                                    title: "In Hand",
                                    total: "₹ ${in_hand.toString()}",
                                    color: Colors.red,
                                    icon: FontAwesomeIcons.wallet,
                                    onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Home()),
                                        )),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 6, right: 6),
                                child: _buildItemCard(
                                    title: "Expenditure",
                                    total:
                                        "₹ ${expenditure.toString()}",
                                    color: Colors.indigo,
                                    icon: FontAwesomeIcons.moneyBill,
                                    onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Home()),
                                        )),
                              )
                            ],
                          ),
                        )))])));
                  }

  }