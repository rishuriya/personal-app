import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_project/expanse/Expanse_Expenditure.dart';
import 'package:personal_project/expanse/Expense_Income.dart';

import '../Home.dart';

class Expanse extends StatefulWidget {
  const Expanse({Key? key}) : super(key: key);

  @override
  State<Expanse> createState() => _ExpanseState();
}

class _ExpanseState extends State<Expanse> {
  List _items = [];
  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/file.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["item"];
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.grey.shade300,
          title: const Text(
            'For You',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Stack(
            children: <Widget>[
              //stack overlaps widgets
              Opacity(
                //semi red clippath with more height and with 0.5 opacity
                opacity: 0.5,
                child: ClipPath(
                  clipper: WaveClipper(), //set our custom wave clipper
                  child: Container(
                    color: Colors.grey.shade400,
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
                                  title: "Income",
                                  total: "Total: 5",
                                  used: "Active: 3",
                                  totalNum: 5,
                                  usedNum: 3,
                                  color: Colors.blue,
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
                                  title: "In Hand",
                                  total: "This month: 10",
                                  used: "Replied: 5",
                                  totalNum: 10,
                                  usedNum: 5,
                                  color: Colors.red,
                                  icon: FontAwesomeIcons.moneyBill,
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
                                  total: "Available: 6",
                                  used: "Member: 2",
                                  totalNum: 6,
                                  usedNum: 2,
                                  color: Colors.indigo,
                                  icon: FontAwesomeIcons.moneyCheck,
                                  onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home()),
                                      )),
                            )
                          ],
                        ),
                      )))
            ],
          ),
          Padding(
              padding: EdgeInsets.all(12),
              child: Container(
                  height: 175,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12),
                          child: SizedBox(
                              width: 175.0,
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
                                          builder: (context) => Income()),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                            text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                                child: Center(
                                            child:FaIcon(
                                              FontAwesomeIcons.add,
                                              color: Colors.blue,
                                              size: 30,
                                            )),),
                                          ],
                                        )),
                                        Divider(
                                          thickness: 1,
                                        ),
                                        SizedBox(height: 10),
                                        Center(
                                          child:RichText(
                                          text: TextSpan(
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
                          padding: EdgeInsets.all(6),
                          child: SizedBox(
                              width: 175.0,
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
                                            text: TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Center(
                                                      child:FaIcon(
                                                        FontAwesomeIcons.subtract,
                                                        color: Colors.blue,
                                                        size: 30,
                                                      )),),
                                              ],
                                            )),
                                        Divider(
                                          thickness: 1,
                                        ),
                                        SizedBox(height: 10),
                                        Center(
                                          child:RichText(
                                            text: TextSpan(
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
              child: Container(
                height:200,
                child:_items.isNotEmpty
                    ?Flex(
                    direction: Axis.vertical,
                    children:[
                      Expanded(
                        child: ListView.builder(
                          itemCount: _items.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.only(left:10,right:10,top:5,bottom: 5),
                              child: ListTile(
                                  isThreeLine: false,
                                  leading: CircleAvatar(
                                    radius: 30,
                                    foregroundImage: NetworkImage(_items[index]["image"]),
                                  ),
                                  title: Text(_items[index]["Name"]),
                                  subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[Padding(padding: EdgeInsets.only(top:0),
                                        child:Text(_items[index]["Artist"]),),
                                        Padding(padding: EdgeInsets.only(top:0),
                                          child:Row(
                                              children:[
                                                Padding(padding: EdgeInsets.only(top:0),
                                                    child:Text("Total Tracks   ")
                                                ),Padding(padding: EdgeInsets.only(top:0),
                                                    child:Text(_items[index]["Tracks"].toString()))]),)]),
                                  trailing: Column(
                                      children:[Padding(padding: EdgeInsets.only(top:5),
                                        child:Icon(
                                          Icons.favorite,
                                        ),),
                                        Padding(padding: EdgeInsets.only(top:5),
                                          child:Text(
                                            _items[index]["Like"].toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black38),
                                          ),)
                                      ]),

                              ),
                            );
                          },
                        ),
                      ), ])
                    : Container(),
                  ),),
        ])));
  }


  Widget _buildItemCard(
      {required String title,
      required String total,
      required String used,
      required int totalNum,
      required int usedNum,
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
                        fontSize: 14,
                      ))),
              SizedBox(height: 10),
              RichText(
                  text: TextSpan(
                      text: used,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ))),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
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
