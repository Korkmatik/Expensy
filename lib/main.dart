import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/transaction.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';
import 'package:expense_planer/widgets/chart.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Planner',
      theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.amber,
          errorColor: Colors.red,
          fontFamily: 'Roboto',
          textTheme: ThemeData.light().textTheme.copyWith(
                button: const TextStyle(color: Colors.white),
              )),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    /*Transaction(
        id: 't1', title: 'New Shoes', amount: 29.99, date: DateTime.now()),
    Transaction(
        id: 't2', title: 'Groceries', amount: 17.42, date: DateTime.now()),*/
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((element) {
      return element.date
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final transaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: chosenDate,
    );
    setState(
      () {
        _transactions.add(transaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Planner'),
        actions: [
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Show Chart'),
              Switch(
                  value: _showChart,
                  onChanged: (value) {
                    setState(() {
                      _showChart = value;
                    });
                  }),
            ],
          ),
          if (_showChart)
            SizedBox(
              width: double.infinity,
              child: Chart(_recentTransactions),
            ),
          Expanded(child: TransactionList(_transactions, _deleteTransaction)),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
