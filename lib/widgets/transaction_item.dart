import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required Transaction transaction,
    required Function deleteTransaction,
  }) : _transaction = transaction, _deleteTransaction = deleteTransaction, super(key: key);

  final Transaction _transaction;
  final Function _deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
            child: Text(
              "${_transaction.amount.toStringAsFixed(2)} €",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Theme.of(context).primaryColor,
              ),
            ),
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 30,
            ),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2.0,
                )),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _transaction.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                DateFormat('MMMM dd, yyyy')
                    .format(_transaction.date),
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(
            width: 90,
          ),
          IconButton(onPressed: () => _deleteTransaction(_transaction.id), icon: const Icon(Icons.delete), color: Theme.of(context).errorColor,),
        ],
      ),
    );
  }
}