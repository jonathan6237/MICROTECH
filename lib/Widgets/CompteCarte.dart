import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import 'package:micfi/main.dart';

class CompteCarte extends StatelessWidget {
  final String title;
  final int amount;
  final DateTime today;
  final String bank;
  CompteCarte(this.title, this.amount, this.bank, this.today);
  @override
  var now = new DateTime.now();
  var formatter = new DateFormat('dd-MM-yyyy');
  Random random = new Random();
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15),
      child: Container(
        width: 270,
        height: 240,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 5, right: 5, bottom: 20),
                child: Container(
                  width: 270,
                  height: 240,
                  decoration: BoxDecoration(
                      color: Colors.orangeAccent[200],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.1),
                            offset: Offset(0, 10),
                            blurRadius: 12)
                      ]),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [Text(title, style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white))],
                  ),
                  Row(
                    children: [Text(amount.toString() + " XAF", style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold, color: Colors.white))],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("*****",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text("*****",style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal, color: Colors.white)),
                      Text(""),
                      Text((random.nextInt(9000) + 1000).toString(),style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal, color: Colors.white)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat(formatter.format(now))
                          .format(now),style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal, color: Colors.white)),
                      Text(bank,style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal, color: Colors.white)),
                    ],
                  ),
                  // Text(bank),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
