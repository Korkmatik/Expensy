import 'package:flutter/material.dart';

import '../models/transaction.dart';
import '../widgets/transaction_list.dart';
import '../widgets/new_transaction.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({Key? key}) : super(key: key);

  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _transactions = [
    Transaction(
        id: 't1', title: 'New Shoes', amount: 29.99, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Groceries', amount: 17.42, date: DateTime.now()),
  ];

  void _addNewTransaction(String title, double amount) {
    final transaction = Transaction(id: DateTime.now().toString(), title: title, amount: amount, date: DateTime.now());
    setState(() {
      _transactions.add(transaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
        TransactionList(_transactions),
      ],
    );
  }
}
