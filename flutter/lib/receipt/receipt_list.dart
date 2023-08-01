import 'package:flutter/material.dart';
import 'package:nonereceipt/controller/retailer_controller.dart';

import '../controller/receipt_controller.dart';
import '../models/retailer.dart';
import '../models/receipt.dart';

class ReceiptListScreen extends StatefulWidget {
  const ReceiptListScreen();

  @override
  _ReceiptListScreenState createState() => _ReceiptListScreenState();
}

class _ReceiptListScreenState extends State<ReceiptListScreen> {
  String? _filterRetailerName;
  List<Retailer>? retailers;
  List<Receipt>? receipts;

  @override
  void initState() {
    super.initState();
    RetailerController.getRetailers().then((value) {
      setState(() {
        retailers = value;
      });
    });
  }

  Future<void> _fetchReceiptsByRetailer(String retailerName) async {
    try {
      List<Receipt> retrievedReceipts =
          await ReceiptController.getReceiptsByRetailerName(retailerName);
      setState(() {
        receipts = retrievedReceipts;
      });
    } catch (e) {
      print('Error fetching receipts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retailers'),
      ),
      body: Center(
        child: Column(
          children: [
            DropdownButton<Retailer>(
              hint: const Text('Select a retailer'),
              onChanged: (Retailer? newValue) {
                setState(() {
                  _filterRetailerName = newValue?.name;
                });
                if (_filterRetailerName != null) {
                  _fetchReceiptsByRetailer(_filterRetailerName!);
                } else {
                  setState(() {
                    receipts = null;
                  });
                }
              },
              items: retailers?.map((Retailer retailer) {
                    return DropdownMenuItem<Retailer>(
                      value: retailer,
                      child: Text(retailer.name),
                    );
                  }).toList() ??
                  [],
            ),
            Expanded(
              child: receipts != null
                  ? ListView.builder(
                      itemCount: receipts!.length,
                      itemBuilder: (context, index) {
                        Receipt receipt = receipts![index];
                        // Build your receipt list item widget here
                        return ListTile(
                          title: Text(receipt.created.toString()),
                          // Add more details if needed
                        );
                      },
                    )
                  : Container(), // Placeholder widget if receipts list is null
            ),
          ],
        ),
      ),
    );
  }
}
