import 'package:flutter/material.dart';
import 'package:nonereceipt/receipt/receipt_details.dart';
import 'package:nonereceipt/receipt/receipt_list.dart';
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
  @override
  void initState() {
    super.initState();
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
