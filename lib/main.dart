import 'package:app_belanja/new_transaction.dart';
import 'package:app_belanja/transaction_list.dart';
import 'package:flutter/material.dart';
import 'transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App_Belanja',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontFamily: 'BungeeHairline',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              labelLarge: const TextStyle(color: Colors.white),
            ),
        appBarTheme: const AppBarTheme(
          textTheme: TextTheme(
            titleLarge: TextStyle(
              fontFamily: 'BungeeHairline',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> userTransactions = [
    // Transaction(
    //   id: 'tx1',
    //   title: 'Sarapan',
    //   amount: 25000,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'tx2',
    //   title: 'Makan siang',
    //   amount: 38000,
    //   date: DateTime.now(),
    // ),
  ];

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void addNewTransaction(String txTitle, int txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      userTransactions.add(newTx);
    });
  }

  void showInputSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return NewTransaction(addNewTransaction);
      },
    );
  }

  void deleteTransaction(String id) {
    setState(() {
      userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        elevation: 5.0,
        title: const Text(
          'Expense Tracker oleh Kelvin Julius Hartono_2501988945',
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 32.0,
              fontFamily: 'BungeeHairline',
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      //Adding gradient background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Color.fromARGB(255, 0, 0, 0),
              Color.fromARGB(255, 39, 9, 147),
              Color.fromARGB(255, 25, 136, 255),
              Color.fromARGB(255, 134, 255, 229),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
            ),
            TransactionList(userTransactions, deleteTransaction),
          ],
        ),
      ),
      //coloring gradient color at the floating button
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        onPressed: () => showInputSheet(context),
        tooltip: 'Tambah Item',
        child: const Icon(Icons.local_grocery_store_rounded, color: Colors.red),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
