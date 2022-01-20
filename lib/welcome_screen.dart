import 'package:flutter/material.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.orangeAccent,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(1),
                    Colors.black.withOpacity(.9),
                    Colors.black.withOpacity(.8),
                    Colors.black.withOpacity(.7),
                    Colors.black.withOpacity(.6),
                    Colors.black.withOpacity(.5),
                    Colors.black.withOpacity(.4),
                    Colors.black.withOpacity(.3),
                    Colors.black.withOpacity(.2),
                    Colors.black.withOpacity(0.05),
                  ]
                )
              ),
            ),
          ),
          Center(
            child: Icon(Icons.money_off_csred_rounded, color: Colors.white,size: 100,),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Text("Welcome to Our World",  style: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.normal, color: Colors.white)),
              ),
              SizedBox(height:30),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      
                    ),
                    child: Padding(padding: EdgeInsets.all(8), child: Icon(Icons.arrow_forward_ios),),
                  ),
                ),
              ),
               SizedBox(height:30),
            ],
          )
        ],
      )
      );
  }
}
