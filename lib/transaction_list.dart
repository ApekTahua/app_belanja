import 'package:flutter/material.dart';
import 'transaction.dart';
import 'package:intl/intl.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionList(this.transactions, this.deleteTx)
      : super(key: const Key('transaction-list'));

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 600,
      child: transactions.isEmpty
          ? Column(
              children: [
                const Text('Belum ada transaksi tercatat  ',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 400,
                  child: Image.asset(
                    'images/duck.gif',
                    fit: BoxFit.cover
                    // width: 200,
                    // height: 20
                    ,
                    alignment: Alignment.center,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.only(
                    top: 15,
                    left: 10,
                    right: 10,
                  ),
                  child: ListTile(
                    leading: IconButton(
                      padding: const EdgeInsets.all(5),
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).colorScheme.error,
                      onPressed: () => deleteTx(transactions[index].id),
                    ),
                    title: Text(transactions[index].title,
                        style: const TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Text(
                      DateFormat.yMMMEd().format(transactions[index].date),
                      style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: GradientText(
                      'Rp. ${transactions[index].amount}',
                      style: const TextStyle(
                          fontFamily: 'Nabla',
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                      gradientType: GradientType.linear,
                      colors: const [
                        Colors.red,
                        Colors.yellow,
                        Colors.green,
                        Colors.blue,
                        Colors.purple,
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
