import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../login.dart';
import '../model.dart';
import 'balance.dart';

int? in_hand=0;
int? in_bank =0;
int? income=0;
int? expenditure =0;
List<Expense> token = [Expense( 0,"", " ","","","RECENT TRANSACTIONS")];
List<Balance> amount = [Balance( 0,0,0,0)];
buildDoctorList() {
  String? uid=user?.uid;
  return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('User').doc(uid).collection('Transaction').orderBy("Day",descending: true).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.data != null){
          for (var element in snapshot.data!.docs) {
            try{int z=0;
              token.add(Expense(element['Amount'],element['Day'], element['Mode'],
                  element['Remark'],element['Source'], element['type']));
            }catch (e){
              continue;
            }
          }
          token.removeAt(0);
          print(token);
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

balance() {
  String? uid=user?.uid;
  String date=DateTime.now().toString().substring(5, 7);
  String year=DateTime.now().toString().substring(0, 4);
  return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection("User").doc(user?.uid).collection("Transaction").doc("amount")
          .collection(year)
          .doc(int.parse(date).toString())
          .snapshots(),
      builder: (context, snapshot) {
        if(snapshot.data != null) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          try {
            amount.add(
                Balance(data["in_bank"],data["in_hand"],data["income"],data["expenditure"]));
          } catch (e) {

          }

          amount.removeAt(0);

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
                  itemCount: (token.length<2)?token.length:1,
                  itemBuilder: (context, index) {
                    return Column(
                      children: (snapshot.data != null) ? ([Balance(
                        amount[index].in_bank,
                        amount[index].in_hand,
                        amount[index].income,
                        amount[index].expenditure,
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