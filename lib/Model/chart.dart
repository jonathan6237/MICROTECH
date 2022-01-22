class Transactions {
  int amount = 0;
  String by = '';
  String from = '';
  String color = '';
  int solde = 0;
  DateTime time = DateTime.now();
  int type = 1;
  Transactions(this.amount, this.by, this.from, this.color, this.solde, this.time, this.type);

  Transactions.fromMap(Map<String,dynamic>map)
  :
  assert(map['amount']!=null),
  assert(map['by']!=null),
  assert(map['from']!=null),
  assert(map['color']!=null),
  assert(map['solde']!=null),
  assert(map['time']!=null),
  assert(map['type']!=null),
  amount = map['amount'],
  by = map['by'],
  from = map['from'],
  color = map['color'],
  solde = map['solde'],
  time = map['time'].toDate(),
  type = map['type'];

  // @override

  // String toString()"Record<$amount:$by:$from:$solde:$time:$type>"; 
}
