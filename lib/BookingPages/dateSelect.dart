import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../ScopedModels/mainmodel.dart';

class DateSelector extends StatefulWidget {
  final MainModel model;
  DateSelector(this.model);

  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime selectedDateFrom = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime selectedDateTo = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  
  DateTime initialDateFrom = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  Future<Null> _selectDateFrom(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDateFrom,
        firstDate: initialDateFrom,
        lastDate: DateTime(2101));
    if (picked != null){
      setState(() {
        selectedDateFrom = picked;
        if(!selectedDateTo.isAfter(selectedDateFrom)){
            selectedDateTo = picked;}
      
      });}
  }

  Future<Null> _selectDateTo(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDateTo,
        firstDate: selectedDateFrom,
        lastDate: DateTime(2101));
    if (picked != null){
      setState(() {
        selectedDateTo = picked;
      });}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: Text('Date Selector'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("${selectedDateFrom.toLocal()}".split(' ')[0]),
            SizedBox(
              height: 20.0,
            ),
           RaisedButton(
             color: Colors.lightBlue,
              onPressed: () => _selectDateFrom(context),
              child: Text('Select date from'),
            ),
            
            SizedBox(
              height: 20.0,
            ),
            Text("${selectedDateTo.toLocal()}".split(' ')[0]),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
             color: Colors.lightBlue,
              onPressed: () => _selectDateTo(context),
              child: Text('Select date to'),
            ),
          ],
        ),
      ),

      
        floatingActionButton: Container(
        height: 170.0,
        width: 170.0,
        child: FittedBox(
          child: FloatingActionButton.extended(
              icon: Icon(Icons.forward),
              backgroundColor: Colors.green,
              label: Text('Proceed to Payment'),
              onPressed: () {
                final difference =
                    selectedDateTo.difference(selectedDateFrom).inDays;
                String diff = difference.toString();
                if (difference == 0) {
                  Fluttertoast.showToast(
                      msg: 'You have Selected 0 days.',
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIos: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                } else {
                  widget.model.updateUserData(selectedDateFrom, selectedDateTo);
                  widget.model.clearRoomIds();
                  Navigator.pushReplacementNamed(context, '/1/' + diff);
                }
                
              }),
        ),
      ),
    );
  }
}
