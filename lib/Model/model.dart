import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Cart {
  String title = "Balance";
  int amount;
  String bank = "micfi";

  Cart(this.title, this.amount, this.bank);
}

final user = FirebaseAuth.instance.currentUser;
int solde = 1;


var cartes = [
  Cart("Solde", solde, "micfi"),
  Cart("Dépot Journalier", solde, "micfi"),
  Cart("Retrait", solde, "micfi"),
];
