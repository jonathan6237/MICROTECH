import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:micfi/Model/chart.dart';
import 'package:intl/intl.dart';

class BarChart extends StatefulWidget {
  const BarChart({Key? key}) : super(key: key);

  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {
  late List<charts.Series<Transactions, String>> _seriesData = [];
  late List<Transactions> myData = [];
  dateformat(timestamp) {
    return (timestamp.day).toString() +
        ", " +
        (timestamp.hour).toString() +
        ":" +
        (timestamp.minute).toString();
  }

  _generateData(myData) {
    _seriesData.add(charts.Series(
        domainFn: (Transactions transaction, _) => dateformat(transaction.time),
        measureFn: (Transactions transaction, _) => transaction.amount,
        colorFn: (Transactions transaction, _) =>
            charts.ColorUtil.fromDartColor(Color(int.parse(transaction.color))),
        id: 'Transactions',
        data: myData,
        labelAccessorFn: (Transactions row, _) => "${row.time}"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(context) {
    var date = DateTime.now();
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Transactions')
          .where('from', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('time',
              isGreaterThanOrEqualTo: DateTime(date.year, date.month, 1))
          .orderBy('time', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<Transactions> transactions = snapshot.data!.docs
              .map((DocumentSnapshot) => Transactions.fromMap(
                  DocumentSnapshot.data() as Map<String, dynamic>))
              .toList();
          return _buildChart(context, transactions);
        }
      },
    );
  }

  Widget _buildChart(BuildContext context, List<Transactions> transactions) {
    myData = transactions;
    _generateData(myData);

    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
                'Statistique de Transaction du Mois numero ' +
                    DateTime.now().month.toString() +
                    ", " +
                    DateTime.now().year.toString(),
                style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 6),
                      blurRadius: 6)
                ]),
            child: Center(
              child: charts.BarChart(
                _seriesData,
                animate: true,
                animationDuration: Duration(seconds: 5),
              ),
            ),
          ),
        ));
  }
}
