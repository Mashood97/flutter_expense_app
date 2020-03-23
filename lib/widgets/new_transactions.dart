import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterexpenseappudemy/widgets/adaptive_flat_button.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction({this.addNewTransaction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void showDatePickerDialog() {
    Platform.isIOS
        ? CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            minimumDate: DateTime(2019),
            maximumDate: DateTime.now(),
            onDateTimeChanged: (dt) {
              if (dt == null) {
                return;
              }
              setState(() {
                _selectedDate = dt;
              });
            },
          )
        : showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2019),
                lastDate: DateTime.now())
            .then((pickedDate) {
            if (pickedDate == null) {
              return;
            }
            setState(() {
              _selectedDate = pickedDate;
            });
          });
  }

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final titleText = titleController.text;
    final amountText = double.parse(amountController.text);
    if (titleText.isEmpty || amountText <= 0 || _selectedDate == null) {
      return;
    }
    widget.addNewTransaction(titleText, amountText, _selectedDate);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Platform.isIOS
                  ? CupertinoTextField(
                      controller: titleController,
                      onSubmitted: (_) => submitData(),
                      placeholder: 'Title',
                    )
                  : TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: titleController,
                      onSubmitted: (_) => submitData(),
                    ),
              Platform.isIOS
                  ? CupertinoTextField(
                      placeholder: 'Amount',
                      controller: amountController,
                      onSubmitted: (_) => submitData(),
                      keyboardType: TextInputType.number,
                    )
                  : TextField(
                      decoration: InputDecoration(labelText: 'Amount'),
                      controller: amountController,
                      onSubmitted: (_) => submitData(),
                      keyboardType: TextInputType.number,
                    ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Choosen'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    AdaptiveFlatButton(
                        title: 'Choose Date', handler: showDatePickerDialog),
                  ],
                ),
              ),
              RaisedButton(
                child: const Text('Add Transaction'),
                textColor: Theme.of(context).textTheme.button.color,
                color: Theme.of(context).primaryColor,
                onPressed: () => submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
