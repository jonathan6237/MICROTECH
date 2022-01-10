import 'package:flutter/material.dart';

class Cart{
  String title="Balance";
  int amount;
  String bank="micfi";
  
  Cart(this.title, this.amount,this.bank);
}

var cartes = [
  Cart("Balance", 450000, "micfi"),
  Cart("Depot", 10000, "micfi"),
];