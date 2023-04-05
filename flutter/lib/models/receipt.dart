class Receipt {
  final String retailer;
  final DateTime created;
  final Map<String, dynamic> items;

  Receipt({
    required this.retailer,
    required this.created,
    required this.items,
  });

  factory Receipt.fromJson(Map<String, dynamic> json) {
    return Receipt(
      retailer: json['retailer'] as String,
      created: DateTime.parse(json['created'] as String),
      items: json['items'] as Map<String, dynamic>,
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
