import 'item.dart';

class Receipt {
  final String retailer;
  final DateTime created;
  final List<Item> items;

  Receipt({
    required this.retailer,
    required this.created,
    required this.items,
  });

  factory Receipt.fromJson(Map<String, dynamic> json) {
    return Receipt(
      retailer: json['retailer'],
      created: DateTime.parse(json['created'] as String),
      items: (json['items'] as List<dynamic>)
          .map((item) => Item.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'retailer': retailer,
      'created': created.toIso8601String(),
      'items': items,
    };
  }
}
