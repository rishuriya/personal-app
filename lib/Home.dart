import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        body: Container(
            child: Stack(
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

              child: Column(children: [
                Padding(
                    padding: EdgeInsets.all(0),
                    child: SizedBox(
                      height: 25.0,
                    )),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: SizedBox(
                      width: 350.0,
                      height: 200.0,
                      child: Card(
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            'GeksForGeeks',
                            style: TextStyle(color: Colors.black),
                          ), //Text
                        ), //Center
                      ), //Card
                    ),
                  ),
                ])
              ]),
            )
          ],
        )));
  }
}

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
