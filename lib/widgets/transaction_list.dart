import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/transaction.dart';

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
            return Card(
              child: Row(
                children: [
                  Container(
                    child: Text(
                      "${_transactions[index].amount.toStringAsFixed(2)} €",
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
                        _transactions[index].title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        DateFormat('MMMM dd, yyyy')
                            .format(_transactions[index].date),
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 90,
                  ),
                  IconButton(onPressed: () => _deleteTransaction(_transactions[index].id), icon: const Icon(Icons.delete), color: Theme.of(context).errorColor,),
                ],
              ),
            );
          },
          itemCount: _transactions.length,
        ),
    );
  }
}
