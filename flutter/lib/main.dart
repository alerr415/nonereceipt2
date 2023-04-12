import 'package:flutter/material.dart';
import 'api/http_api.dart';
import 'models/receipt.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

// ignore: must_be_immutable
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
        '/receipts': (context) => const ReceiptListScreen(),
        '/receipt': (context) => ReceiptDetailsScreen(
            ModalRoute.of(context)!.settings.arguments as Receipt),
      },
    );
  }
}

//ignore: prefer_const_constructors
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

// ignore: use key in widget constructors
class ReceiptDetailsScreen extends StatelessWidget {
  final Receipt receipt;

  const ReceiptDetailsScreen(this.receipt);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receipt.retailer),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
