import 'package:flutter/material.dart';

import '../models/receipt.dart';

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
            Text(
              "Retailer: ${receipt.retailer}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              "Created: ${receipt.created}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            const Text(
              "Items:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: receipt.items.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "- ${item.name}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        "  Quantity: ${item.quantity}",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      Text(
                        "  Price: \$${item.price}",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
