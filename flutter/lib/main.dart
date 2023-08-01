import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nonereceipt/receipt/receipt_details.dart';

import 'models/receipt.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    startNfcReading();
  }

  @override
  void dispose() {
    stopNfcReading();
    super.dispose();
  }

  Future<void> startNfcReading() async {
    if (await NfcManager.instance.isAvailable()) {
      NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
        Ndef? ndef = Ndef.from(tag);
        if (ndef == null) {
          NfcManager.instance.stopSession();
          return;
        }

        NdefMessage msg = await ndef.read();
        String payload = utf8.decode(msg.records.first.payload);
        Receipt receipt = Receipt.fromJson(jsonDecode(payload));

        NfcManager.instance.stopSession();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReceiptDetailsScreen(receipt),
          ),
        );
      });
    } else {
      // Handle NFC not available
    }
  }

  void stopNfcReading() {
    NfcManager.instance.stopSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NoneReceipt')),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Scan a receipt to get started'),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
