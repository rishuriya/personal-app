import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model.dart';

int? in_bank;
int? in_hand;

List<Expense> token = [Expense( 0,"", " ","","","RECENT TRANSACTIONS")];
buildDoctorList() {

  return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Transaction').orderBy("Day",descending: true).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.data != null){
          for (var element in snapshot.data!.docs) {
            try{
              print("hello");
              token.add(Expense(element['Amount'],element['Day'], element['Mode'],
                  element['Remark'],element['Source'], element['type']));
            }catch (e){
              continue;
            }
          }
          token.removeAt(0);
        }

        return  Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Column(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: (token.length<=11)?token.length:11,
                  itemBuilder: (context, index) {
                    return Column(
                      children: (snapshot.data != null) ? ([Expense(
                        token[index].amount,
                        token[index].date,
                        token[index].mode,
                        token[index].remark,
                        token[index].source,
                        token[index].type,

                      ),
                        const SizedBox(height: 10,)
                      ]) : ([const CircularProgressIndicator()]),
                    );
                  },
                ),
                const SizedBox(height: 80),
              ],
            )
        );
      });
}
