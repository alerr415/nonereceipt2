// import 'package:flutter/material.dart';
// import 'api/http_api.dart';
// import 'models/receipt.dart';
// import 'dart:convert';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late Future<List<Receipt>> _futureReceipts;

//   @override
//   void initState() {
//     super.initState();
//     _futureReceipts = HttpClient.testRequest();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('NoneReceipt')),
//         body: FutureBuilder<List<Receipt>>(
//           future: _futureReceipts,
//           builder:
//               (BuildContext context, AsyncSnapshot<List<Receipt>> snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             } else if (snapshot.hasData) {
//               List<Receipt> receipts = snapshot.data!;
//               return ListView.builder(
//                 itemCount: receipts.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               ReceiptDetailsScreen(receipts[index]),
//                         ),
//                       );
//                     },
//                     child: ListTile(
//                       title: Text(receipts[index].body),
//                       subtitle: Text(receipts[index].created.toString()),
//                     ),
//                   );
//                 },
//               );
//             } else if (snapshot.hasError) {
//               return Text("Error: ${snapshot.error}");
//             } else {
//               return const Text("No data.");
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// class ReceiptDetailsScreen extends StatelessWidget {
//   final Receipt receipt;

//   ReceiptDetailsScreen(this.receipt);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(receipt.body),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Body: ${receipt.body}"),
//             Text("Created: ${receipt.created}"),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'api/http_api.dart';
import 'models/receipt.dart';
import 'models/retailer.dart';
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
  late Future<List<Retailer>> _futureRetailers;

  @override
  void initState() {
    super.initState();
    _futureRetailers = HttpClient.fetchRetailers();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => RetailerListScreen(_futureRetailers),
        '/receipts': (context) => ReceiptListScreen(
            ModalRoute.of(context)!.settings.arguments as Retailer),
        '/receipt': (context) => ReceiptDetailsScreen(
            ModalRoute.of(context)!.settings.arguments as Receipt),
      },
    );
  }
}

class RetailerListScreen extends StatelessWidget {
  final Future<List<Retailer>> futureRetailers;

  RetailerListScreen(this.futureRetailers);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NoneReceipt')),
      body: FutureBuilder<List<Retailer>>(
        future: futureRetailers,
        builder:
            (BuildContext context, AsyncSnapshot<List<Retailer>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            List<Retailer> retailers = snapshot.data!;
            return ListView.builder(
              itemCount: retailers.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/receipts',
                      arguments: retailers[index],
                    );
                  },
                  child: ListTile(
                    title: Text(retailers[index].name),
                    subtitle: Text(retailers[index].address),
                  ),
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
    );
  }
}

class ReceiptListScreen extends StatefulWidget {
  final Retailer retailer;

  ReceiptListScreen(this.retailer);

  @override
  _ReceiptListScreenState createState() => _ReceiptListScreenState();
}

class _ReceiptListScreenState extends State<ReceiptListScreen> {
  late Future<List<Receipt>> _futureReceipts;

  @override
  void initState() {
    super.initState();
    _futureReceipts = HttpClient.fetchReceiptsByRetailer(widget.retailer.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.retailer.name)),
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
                      '/receipt',
                      arguments: receipts[index],
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
        title: Text(receipt.body),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Body: ${receipt.body}"),
            Text("Created: ${receipt.created}"),
          ],
        ),
      ),
    );
  }
}

class RetailerDetailsScreen extends StatefulWidget {
  final Retailer retailer;

  RetailerDetailsScreen(this.retailer);

  @override
  _RetailerDetailsScreenState createState() => _RetailerDetailsScreenState();
}

class _RetailerDetailsScreenState extends State<RetailerDetailsScreen> {
  late Future<List<Receipt>> _futureReceipts;

  @override
  void initState() {
    super.initState();
    _futureReceipts = HttpClient.getReceiptsByRetailer(widget.retailer.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.retailer.name),
      ),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ReceiptDetailsScreen(receipts[index]),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text("${receipts[index].created}"),
                  ),
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
    );
  }
}
