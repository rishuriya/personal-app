import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:personal_project/Home.dart';
class Expense extends StatelessWidget {

  final String? date;
  final String? mode ;
  final String? amount;
  final String? source;
  final String? remark;
  final String? type;

  Expense(
      this.amount,
        this.date,
        this.mode,
      this.remark,
        this.source,
      this.type,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(builder: (context)
        => Home()));
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.purple.shade200.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: FutureBuilder(

            builder: (context,AsyncSnapshot<Uint8List?> snapshot) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  isThreeLine: false,
                  title: Text(type!),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[Padding(padding: EdgeInsets.only(top:0),
                        child:Text(amount!),),
                        Padding(padding: EdgeInsets.only(top:0),
                          child:Row(
                              children:[
                                Padding(padding: EdgeInsets.only(top:0,right:12),
                                    child:Text(date!)
                                ),Padding(padding: EdgeInsets.only(top:0,),
                                    child:Text(remark!))]),)]),
                  trailing: Column(
                      children:[Padding(padding: EdgeInsets.only(top:5),
                        child:Text(source!)),
                        Padding(padding: EdgeInsets.only(top:5),
                          child:Text(
                            mode!,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black38),
                          ),)
                      ]),

                ),
              );
            }
        ),
      ),
    );
  }

}