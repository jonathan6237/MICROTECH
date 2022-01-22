import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class crudMethods {
  final user = FirebaseAuth.instance.currentUser;
  final Stream<QuerySnapshot> _transStream =
      FirebaseFirestore.instance.collection('Transactions').snapshots();
  bool isLoggedIn() {
    if (user == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> addData(int montant) async {
    int document = 0;
    await FirebaseFirestore.instance
        .collection('Transactions')
        .where('from', isEqualTo: user!.uid)
        .orderBy('time', descending: true)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
         document = doc["solde"];
        print(document);
      });
    });
    String userId = user!.uid;
    Map<String, Object?> transData = {
      'from': userId,
      'by': userId,
      'amount': montant,
      'solde': document + montant,
      'color': '0xFF0000CC',
      'type': 1,
      'time': DateTime.now()
    };
    print(transData);
    FirebaseFirestore.instance
        .collection('Transactions')
        .add(transData)
        .catchError((e) {
      print(e);
    });
  }
  Future<void> addDepot(int montant, String id) async {
    int document = 0;
    await FirebaseFirestore.instance
        .collection('Transactions')
        .where('from', isEqualTo: id)
        .orderBy('time', descending: true)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
         document = doc["solde"];
        print(document);
      });
    });
    String userId = user!.uid;
    Map<String, Object?> transData = {
      'from': id,
      'by': userId,
      'amount': montant,
      'solde': document + montant,
      'color': '0xFF0000CC',
      'type': 1,
      'time': DateTime.now()
    };
    print(transData);
    FirebaseFirestore.instance
        .collection('Transactions')
        .add(transData)
        .catchError((e) {
      print(e);
    });
  }
  Future<void> addRetrait(int montant, String id) async {
    int document = 0;
    await FirebaseFirestore.instance
        .collection('Transactions')
        .where('from', isEqualTo: id)
        .orderBy('time', descending: true)
        .limit(1)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
         document = doc["solde"];
        print(document);
      });
    });
    String userId = user!.uid;
    Map<String, Object?> transData = {
      'from': id,
      'by': userId,
      'amount': montant,
      'solde': document - montant,
      'color': '0xFFFFFF33',
      'type': 0,
      'time': DateTime.now()
    };
    print(transData);
    FirebaseFirestore.instance
        .collection('Transactions')
        .add(transData)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> sendRequest(String req) async {
    Map<String, Object?> cartData = {'requete': req};
    FirebaseFirestore.instance
        .collection('Requetes')
        .add(cartData)
        .catchError((e) {
      print(e);
    });
  }

  getData() async {
    return await FirebaseFirestore.instance.collection('Transactions');
  }
}
