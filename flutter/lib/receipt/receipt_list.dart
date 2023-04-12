import 'package:flutter/material.dart';
import 'package:nonereceipt/receipt/receipt_details.dart';
import '../models/receipt.dart';
import '../api/http_api.dart';

class ReceiptListScreen extends StatefulWidget {
  const ReceiptListScreen();

  @override
  _ReceiptListScreenState createState() => _ReceiptListScreenState();
}

class _ReceiptListScreenState extends State<ReceiptListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('testTitle')),
      body: FutureBuilder<List<Receipt>>(
        future: HttpClient.fetchReceipts(),
        builder: (BuildContext context, AsyncSnapshot<List<Receipt>> snapshot) {
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
    );
  }
}
