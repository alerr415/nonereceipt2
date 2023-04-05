import 'package:flutter/material.dart';
import 'api/http_api.dart';
import 'models/receipt.dart';
import 'models/retailer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Receipt>> _futureReceipts;

  @override
  void initState() {
    super.initState();
    _futureReceipts = HttpClient.fetchReceipts();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/receipts',
      routes: {
        '/receipts': (context) => ReceiptListScreen(
            ModalRoute.of(context)!.settings.arguments as Receipt),
        '/receipt': (context) => ReceiptDetailsScreen(
            ModalRoute.of(context)!.settings.arguments as Receipt),
      },
    );
  }
}

class ReceiptListScreen extends StatefulWidget {
  final Receipt receipt;

  ReceiptListScreen(this.receipt);

  @override
  _ReceiptListScreenState createState() => _ReceiptListScreenState();
}

class _ReceiptListScreenState extends State<ReceiptListScreen> {
  late Future<List<Receipt>> _futureReceipts;

  @override
  void initState() {
    super.initState();
    _futureReceipts = HttpClient.fetchReceipts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receipt.retailer)),
      body: FutureBuilder<List<Receipt>>(
        future: _futureReceipts,
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
                    Navigator.pushNamed(
                      context,
                      '/receipts',
                      arguments: receipts,
                    );
                  },
                  child: ListTile(
                    title: Text("Receipt ${receipts[index].created}"),
                  ),
                );
              },
            );
          } else
            return const Text("No data.");
        },
      ),
    );
  }
}

class ReceiptDetailsScreen extends StatelessWidget {
  final Receipt receipt;

  ReceiptDetailsScreen(this.receipt);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receipt.retailer),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Retailer: ${receipt.retailer}"),
            Text("Created: ${receipt.created}"),
            Text("Items: ${receipt.items}"),
          ],
        ),
      ),
    );
  }
}
