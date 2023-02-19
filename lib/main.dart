import 'package:flutter/material.dart';
import 'api/http_api.dart';
import 'models/receipt.dart';
import 'dart:convert';

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
    _futureReceipts = HttpClient.testRequest();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('NoneReceipt')),
        body: FutureBuilder<List<Receipt>>(
          future: _futureReceipts,
          builder:
              (BuildContext context, AsyncSnapshot<List<Receipt>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              List<Receipt> receipts = snapshot.data!;
              return ListView.builder(
                itemCount: receipts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(receipts[index].body),
                    subtitle: Text(receipts[index].created.toString()),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return const Text("No data.");
            }
          },
        ),
      ),
    );
  }
}
