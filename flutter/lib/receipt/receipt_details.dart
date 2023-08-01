import 'package:flutter/material.dart';
import '../models/receipt.dart';

class ReceiptDetailsScreen extends StatelessWidget {
  final Receipt receipt;

  const ReceiptDetailsScreen(this.receipt);

  @override
  Widget build(BuildContext context) {
    // Calculate the sum of item prices
    double sum = receipt.items.fold(0, (total, item) => total + item.price);

    return Scaffold(
      appBar: AppBar(
        title: Text(receipt.retailer),
      ),
      backgroundColor: Colors
          .grey[500], // Set the main page background color to a darker shade
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey[
                200], // Set the receipt frame background color to off-white
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 2),
                blurRadius: 4.0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                receipt.retailer,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                receipt.created
                    .toIso8601String()
                    .split("T")[0], // Format and remove time component
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var item in receipt.items)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "- ${item.name}",
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            "\$${item.price.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 8),
                  const Divider(
                    thickness: 2,
                    height: 2,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total:",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$${sum.toStringAsFixed(2)}", // Display the sum of item prices
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
