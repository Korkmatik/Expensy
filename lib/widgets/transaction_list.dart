import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;

  TransactionList(this._transactions);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ...(_transactions
            .map(
              (e) => Card(
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        "${e.amount} €",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.purple,
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 30,
                      ),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.purple,
                        width: 2.0,
                      )),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          DateFormat('MMMM dd, yyyy').format(e.date),
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
            .toList()),
      ],
    );
  }
}
