// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:micfi/account_cart.dart';


// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final _auth = FirebaseAuth.instance;

//   void initState() {
//     super.initState();
//     getCurrentUser();
//   }

//   //using this function you can use the credentials of the user
//   void getCurrentUser() async {
//     try {
//       final user = await _auth.currentUser;
//       if (user != null) {
//        User loggedinUser = user;
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: <Widget>[
//           IconButton(
//               icon: Icon(Icons.close),
//               onPressed: () {
//                 _auth.signOut();
//                 Navigator.pop(context);
//               }),
//         ],
//         title: Text('Home Page'),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Center(
//         child: AccountCart(),
//       ),
//         bottomNavigationBar: ConvexAppBar(
//         style: TabStyle.reactCircle,
//         items: [
//           TabItem(icon: Icons.home),
//           TabItem(icon: Icons.gradient_sharp),
//           TabItem(icon: Icons.person)
//         ],
//         initialActiveIndex: 1,
//         onTap: (int i) => print('click index=$i'),
//       ),
//     );
//   }
// }