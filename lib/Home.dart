import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:waveprogressbar_flutter/waveprogressbar_flutter.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}



class _HomeState extends State<Home> {
  @override
  double waterHeight=0.0;
  WaterController waterController=WaterController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding widgetsBinding=WidgetsBinding.instance;
    widgetsBinding.addPostFrameCallback((callback){
      waterController.changeWaterHeight(0.87);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.deepPurple.shade300,
          title: const Text(
            'For You',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        body: Column(children: [
             Stack(
          children: <Widget>[
            //stack overlaps widgets
            Opacity(
              //semi red clippath with more height and with 0.5 opacity
              opacity: 1,
              child: ClipPath(
                clipper: WaveClipper(), //set our custom wave clipper
                child: Container(
                  color: Colors.deepPurple.shade300,
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
        ),
         Column(
          children: [
            Padding(padding: EdgeInsets.all(12),
    child:
         StaggeredGrid.count(
         crossAxisCount: 4,
         mainAxisSpacing: 4,
         crossAxisSpacing: 4,
         children:  [
         StaggeredGridTile.count(
         crossAxisCellCount: 2,
         mainAxisCellCount: 2,
         child: Container(
             alignment: Alignment.center,
             child: new Center(
               child: new WaveProgressBar(
                 flowSpeed: 2.0,
                 waveDistance:45.0,
                 waterColor: Color(0xFF68BEFC),
                 //strokeCircleColor: Color(0x50e16009),
                 heightController: waterController,
                 percentage: waterHeight,
                 size: new Size (300,300),
                 circleStrokeWidth: 0,
                 text: "Expanse",
                 textStyle: new TextStyle(
                     color:Color(0x15000000),
                     fontSize: 30.0,
                     fontWeight: FontWeight.bold),
               ),
             ),
           decoration: new BoxDecoration(
             borderRadius: new BorderRadius.circular(26.0),
             color: Colors.lightBlue.shade100,
           )
         ),
         ),
         StaggeredGridTile.count(
         crossAxisCellCount: 2,
         mainAxisCellCount: 1,
           child: Container(
             alignment: Alignment.center,
             child: Text("Expanse",),
             decoration: new BoxDecoration(
               borderRadius: new BorderRadius.circular(26.0),
             color: Colors.orangeAccent.shade100,
    ),
           ),
         ),
         StaggeredGridTile.count(
         crossAxisCellCount: 2,
         mainAxisCellCount: 1,
           child: Container(
             alignment: Alignment.center,
             child: Text("Expanse",),
             decoration: new BoxDecoration(
               borderRadius: new BorderRadius.circular(26.0),
               color: Colors.green.shade100,
             ),
           ),
         ),

    ],
    ),
            ),

          ],

        )]));
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
