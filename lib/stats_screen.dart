import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  final user = FirebaseAuth.instance.currentUser;
  final Stream<QuerySnapshot> _transStream = FirebaseFirestore.instance
      .collection('Transactions')
      .where('from', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .orderBy('time', descending: true)
      .snapshots();

  String trans = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFf3f6fb),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text('Historique de Transaction',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                  padding: EdgeInsets.only(top: 5, left: 16, bottom: 10),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: _transStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Text("Loading");
                        }
                        return SizedBox(
                          height: 1000,
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              if (data['type'] == 1) {
                                trans = "Depot";
                              } else {
                                trans = "Retrait";
                              }
                              DateTime myDateTime = data['time'].toDate();
                              return Card(
                                child: ListTile(
                                  leading: Icon(
                                    Icons.repeat_on_rounded,
                                    color: Colors.orangeAccent,
                                    size: 45,
                                  ),
                                  title: Text("Montant $trans : " +
                                      (data['amount']).toString()),
                                  subtitle: Text((DateFormat.yMMMd()
                                              .add_jm()
                                              .format(myDateTime))
                                          .toString() +
                                      '                   Par:' +
                                      data['by'] +
                                      '            Solde Restant :' +
                                      (data['solde']).toString()),
                                  trailing: Icon(Icons.check),
                                  isThreeLine: true,
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      })),
            ],
          ),
        ));
  }
}
