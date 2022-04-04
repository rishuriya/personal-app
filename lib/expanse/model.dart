import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_project/Home.dart';
import 'package:personal_project/expanse/Expanse_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'var/var.dart';
class Expense extends StatelessWidget {
  final String? date;
  final String? mode;

  final int? amount;
  final String? source;
  final String? remark;
  final String? type;

  Expense(this.amount,
      this.date,
      this.mode,
      this.remark,
      this.source,
      this.type, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(builder: (context) => const Home()));
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent.shade100.withOpacity(0.4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: FutureBuilder(
            builder: (context, AsyncSnapshot<Uint8List?> snapshot) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: ListTile(
                  isThreeLine: false,
                  title: Text(type!),
                  subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Padding(padding: EdgeInsets.only(top: 0),
                        child: Text(amount.toString()),),
                        Padding(padding: EdgeInsets.only(top: 0),
                          child: Row(
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(top: 0, right: 12),
                                    child: Text(date!)
                                ), Padding(padding: EdgeInsets.only(top: 0,),
                                    child: Text(remark!))
                              ]),)
                      ]),
                  trailing: Column(
                      children: [Padding(padding: EdgeInsets.only(top: 5),
                          child: Text(source!)),
                        Padding(padding: EdgeInsets.only(top: 5),
                          child: Text(
                            mode!,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black38),
                          ),),
                Padding(padding: EdgeInsets.only(top:5),
                        child:
                        cal(),
                )
                      ]),

                ),
              );
            }
        ),
      )
    ); }

  cal() {
    String date=DateTime.now().toString().substring(5, 7);
    if (type == 'INCOME' && mode == 'Bank') {
      in_bank = in_bank! + amount!;
      income=income!+amount!;
    }if (type == 'INCOME' && mode == 'Cash' && source=="Bank") {
      in_bank = in_bank! - amount!;
      in_hand=in_hand!+amount!;
    }if (type == 'INCOME' && mode == 'Cash' && source!="Bank") {
      in_hand=in_hand!+amount!;
      income=income!+amount!;
    }
    if (type == 'EXPENDITURE' && mode == 'Upi') {
      in_bank = in_bank! - amount!;
      expenditure=expenditure!+amount!;
    }
    if (type == 'EXPENDITURE' && mode == 'Cash') {
      in_hand = in_hand! - amount!;
      expenditure=expenditure!+amount!;
    }

    DocumentReference ref= FirebaseFirestore.instance
        .collection('Transaction').doc("amount").collection("Rishav").doc(date);
    ref.set({
      "in_bank":in_bank,
      "in_hand":in_hand,
      "income":income,
      "expenditure":expenditure
    });

  }
}