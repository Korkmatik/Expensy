import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _deleteTransaction;

  const TransactionList(this._transactions, this._deleteTransaction,  {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: _transactions.isEmpty ? Column(children: [
          Text('No Transaction added yet!', style: Theme.of(context).textTheme.headline6,),
          const SizedBox(height: 20,),
          SizedBox(height: 20, child: Image.asset('assets/images/hourglass-split.png', fit: BoxFit.cover,)),
        ],) : ListView.builder(
          itemBuilder: (context, index) {
            return TransactionItem(transaction: _transactions[index], deleteTransaction: _deleteTransaction);
          },
          itemCount: _transactions.length,
        ),
    );
  }
}
