import 'package:flutter/material.dart';
import '/Model/model.dart';
import 'Widgets/CompteCarte.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/crud.dart';

class AccountCart extends StatefulWidget {
  const AccountCart({Key? key}) : super(key: key);

  @override
  _AccountCartState createState() => _AccountCartState();
}

class _AccountCartState extends State<AccountCart> {
  final _auth = FirebaseAuth.instance;
  crudMethods crudObject = new crudMethods();
  final myController = TextEditingController();
  final depotController = TextEditingController();
  final retraitController = TextEditingController();
  final reqController = TextEditingController();
  bool value = false;
  bool val = false;
  String _checked ="";
   String docId='';
  bool _isEnable = true;
  final Stream<QuerySnapshot> _transStream =
      FirebaseFirestore.instance.collection('Users').snapshots();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    reqController.dispose();
    super.dispose();
  }

  //using this function you can use the credentials of the user
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        User loggedinUser = user;
        print(user.uid);
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    super.initState();
    int _currentIndex = 0;
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf3f6fb),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text('Mon Compte',
                  style:
                      TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 240,
              child: ListView.builder(
                  itemCount: cartes.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var cart = cartes[index];
                    return CompteCarte(
                      cart.title,
                      cart.amount,
                      cart.bank,
                      DateTime.now(),
                    );
                  }),
            ),
            Container(
              width: double.infinity,
              height: 160,
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text("Nos Offres",
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold)),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(left: 6, bottom: 10),
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 6),
                                  blurRadius: 6)
                            ]),
                        child: Padding(
                          padding: EdgeInsets.only(left: 22, top: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Pret, 2% de reduction!!!!. Rendez-vous a l'agence la plus proche.........................................."),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Text('Effectuer un depot',
                  style:
                      TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 22,
            ),
            Container(
              width: double.infinity,
              height: 60,
              margin: EdgeInsets.symmetric(horizontal: 22),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.12),
                        offset: Offset(0, 10),
                        blurRadius: 30)
                  ]),
              child: Center(
                child: Padding(
                    padding: EdgeInsets.only(left: 18, right: 12),
                    child: TextField(
                      enabled: _isEnable,
                      controller: myController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Montant . . . .",
                        suffixIcon: IconButton(
                            icon: Icon(Icons.send),
                            // onPressed: () => (crudObject.addData(int.parse(myController.text))),
                            onPressed: () async {
                              setState(() {
                                _isEnable = false;
                              });
                              try {
                                if (!(_isEnable)) {
                                  (crudObject
                                      .addData(int.parse(myController.text)));
                                }
                              } catch (err) {
                                print(err);
                                Text(err.toString());
                              }
                              enable:
                              false;
                            }),
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Container(
              width: double.infinity,
              height: 60,
              margin: EdgeInsets.symmetric(horizontal: 22),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.12),
                        offset: Offset(0, 10),
                        blurRadius: 30)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StreamBuilder<QuerySnapshot>(
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
                        return Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              return Card(
                                elevation: 0,
                                child: ListTile(
                                  leading: StatefulBuilder(
                                    builder: (BuildContext context,
                                            StateSetter setState) =>
                                        Checkbox(
                                      value: value,
                                      onChanged: (values) {
                                        setState(() {
                                          value = values!;
                                          print(value);
                                          if (value == true) {
                                            
                                          print(document.id);
                                          _checked = document.id;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  title: Text(data['UserName'].toString()),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }),
                  Expanded(
                    child: TextField(
                      enabled: _isEnable,
                      controller: depotController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Montant . . . .",
                        suffixIcon: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () async {
                              setState(() {
                                _isEnable = false;
                              });
                              try {
                                if (!(_isEnable)) {
                                  (crudObject
                                      .addDepot(int.parse(depotController.text), _checked));
                                }
                              } catch (err) {
                                print(err);
                                Text(err.toString());
                              }
                              enable:
                              false;
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Text('Effectuer un Retrait',
                  style:
                      TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 22,
            ),
           
            Container(
              width: double.infinity,
              height: 60,
              margin: EdgeInsets.symmetric(horizontal: 22),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.12),
                        offset: Offset(0, 10),
                        blurRadius: 30)
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StreamBuilder<QuerySnapshot>(
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
                        return Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              return Card(
                                elevation: 0,
                                child: ListTile(
                                  leading: StatefulBuilder(
                                    builder: (BuildContext context,
                                            StateSetter setState) =>
                                        Checkbox(
                                      value: val,
                                      onChanged: (values) {
                                        setState(() {
                                          val = values!;
                                          print(value);
                                          if (val == true) {
                                            
                                          print(document.id);
                                          _checked = document.id;
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  title: Text(data['UserName'].toString()),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }),
                  Expanded(
                    child: TextField(
                      enabled: _isEnable,
                      controller: depotController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Montant . . . .",
                        suffixIcon: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () async {
                              setState(() {
                                _isEnable = false;
                              });
                              try {
                                if (!(_isEnable)) {
                                  (crudObject
                                      .addRetrait(int.parse(depotController.text), _checked));
                                }
                              } catch (err) {
                                print(err);
                                Text(err.toString());
                              }
                              enable:
                              false;
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Container(
              width: double.infinity,
              height: 60,
              margin: EdgeInsets.symmetric(horizontal: 22),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.12),
                        offset: Offset(0, 10),
                        blurRadius: 30)
                  ]),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 18, right: 12),
                  child: TextField(
                      controller: reqController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Une requête ? ? ? Besoin d'une info ? ? ?",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.message),
                          onPressed: () =>
                              (crudObject.sendRequest(reqController.text)),
                        ),
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
