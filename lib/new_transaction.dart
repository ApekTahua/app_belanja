import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  const NewTransaction(this.addTx) : super(key: const Key('new-transaction'));

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = int.parse(amountController.text);

    if (amountController.text.isEmpty ||
        enteredTitle.isEmpty ||
        enteredAmount <= 0) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount, selectedDate);

    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Title'),
            controller: titleController,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Amount'),
            controller: amountController,
            keyboardType: TextInputType.number,
          ),
          Row(
            children: [
              Expanded(
                child: Text(selectedDate == null
                    ? 'No Date Chosen!'
                    : 'Picked Date: ${DateFormat.yMMMEd().format(selectedDate)}'),
              ),
              TextButton(
                onPressed: presentDatePicker,
                child: const Text('Choose Date'),
              ),
            ],
          ),
          ElevatedButton(
            //adding margin to the button and center it
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              shadowColor: Colors.grey,
              elevation: 5,
            ),
            onPressed: () => submitData(),
            child: const Text(
              'Add Transaction',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'BungeeHairline'),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
