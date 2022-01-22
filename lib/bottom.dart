import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:micfi/Widgets/barChart.dart';
import 'package:micfi/account_cart.dart';
import 'package:micfi/stats_screen.dart';

class ButtomNav extends StatefulWidget {
  const ButtomNav({Key? key}) : super(key: key);

  @override
  _ButtomNavState createState() => _ButtomNavState();
}

// This is the bottom nav Bar. It simply shows the three buttons at the bottom of the page and manages the navigation between pages

// Note: The overide keyword is used for inheritance

class _ButtomNavState extends State<ButtomNav> {
  int _currentIndex = 0;
  void changePage(int? index) {
    super.setState(() {
      _currentIndex = index!;
    });
  }

  var screens = [
    AccountCart(),
    BarChart(),
    Stats(),
  ];

  void initState() {
    super.initState();
    int _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf3f6fb),
      appBar: AppBar(
        elevation:0,
        backgroundColor: Color(0xFFf3f6fb),
        centerTitle: true,
        title: Text('Micfi'),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.sort, color: Colors.black,),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.person, color: Colors.black,),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 0),
        child: BubbleBottomBar(
           backgroundColor: Color(0xFFf3f6fb),
          opacity: 1,
          elevation: 0,
          currentIndex: _currentIndex,
          onTap: changePage,
          items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(
                backgroundColor: Colors.black,
                icon: Icon(Icons.home, color: Colors.black),
                activeIcon: Icon(Icons.home, color: Colors.white),
                title: Text("Home", style: TextStyle(color: Colors.white))),
            BubbleBottomBarItem(
                backgroundColor: Colors.black,
                icon:
                    Icon(Icons.stacked_bar_chart_rounded, color: Colors.black),
                activeIcon:
                    Icon(Icons.stacked_bar_chart_rounded, color: Colors.white),
                title: Text("Statistics", style: TextStyle(color: Colors.white))),
            BubbleBottomBarItem(
                backgroundColor: Colors.black,
                icon: Icon(Icons.history_edu_rounded, color: Colors.black),
                activeIcon: Icon(Icons.history_edu_rounded, color: Colors.white),
                title: Text("History", style: TextStyle(color: Colors.white))),
          ],
        ),
      ),
      body: screens[_currentIndex],
    );
  }
}
