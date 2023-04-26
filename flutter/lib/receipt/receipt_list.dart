import 'package:flutter/material.dart';
import 'package:nonereceipt/controller/receipt_controller.dart';
import 'package:nonereceipt/controller/retailer_controller.dart';
import 'package:nonereceipt/receipt/receipt_details.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../models/receipt.dart';
import '../models/retailer.dart';

class ReceiptListScreen extends StatefulWidget {
  const ReceiptListScreen();

  @override
  _ReceiptListScreenState createState() => _ReceiptListScreenState();
}

class _ReceiptListScreenState extends State<ReceiptListScreen> {
  String? _filterRetailerName;
  List<Retailer>? retailers;
  @override
  void initState() {
    super.initState();
    RetailerController.getRetailers().then((value) {
      setState(() {
        retailers = value;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('testTitle')),
      body: Column(
        children: [
          DropdownSearch<Retailer>(
            items: retailers ?? [],
            itemAsString: (Retailer retailer) => retailer.name,
            onChanged: (value) {
              setState(() {
                _filterRetailerName = value?.name;
              });
            },
            selectedItem: _filterRetailerName == null
                ? null
                : _filterRetailerName == ""
                    ? null
                    : retailers?.firstWhere(
                        (element) => element.name == _filterRetailerName),
          ),
          FutureBuilder<List<Receipt>>(
            future: _filterRetailerName != null
                ? ReceiptController.getReceiptsByRetailerName(
                    _filterRetailerName!)
                : ReceiptController.getReceipts(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Receipt>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                List<Receipt> receipts = snapshot.data!;
                return ListView.builder(
                  itemCount: receipts.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ReceiptDetailsScreen(receipts[index]),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text("Receipt ${receipts[index].created}"),
                      ),
                    );
                  },
                );
              } else {
                return const Text("No data.");
              }
            },
          ),
        ],
      ),
    );
  }
}
