import 'package:flutter/material.dart';
import 'package:nonereceipt/controller/retailer_controller.dart';

import '../models/retailer.dart';

class ReceiptListScreen extends StatefulWidget {
  const ReceiptListScreen();

  @override
  _ReceiptListScreenState createState() => _ReceiptListScreenState();
}

class _ReceiptListScreenState extends State<ReceiptListScreen> {
  List<Retailer>? retailers;
  @override
  void initState() {
    super.initState();
    RetailerController.getRetailers().then((value) {
      setState(() {
        retailers = value;
      });
    });
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retailers'),
      ),
      body: Center(
        child: DropdownButton<Retailer>(
          hint: const Text('Select a retailer'),
          onChanged: (Retailer? newValue) {
            setState(() {
              _filterRetailerName = newValue?.name;
              print(newValue?.name);
            });
            // Perform any additional filtering or actions based on the selected retailer
          },
          items: retailers?.map((Retailer retailer) {
            return DropdownMenuItem<Retailer>(
              value: retailer,
              child: Text(retailer.name),
            );
          }).toList() ??
              [],
        ),
      ),
    );
  }
}
