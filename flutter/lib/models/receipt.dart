class Receipt {
  final String body;
  final DateTime created;

  Receipt({
    required this.body,
    required this.created,
  });

  factory Receipt.fromJson(Map<String, dynamic> json) {
    return Receipt(
      body: json['body'] as String,
      created: DateTime.parse(json['created'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'body': body,
      'created': created.toIso8601String(),
    };
  }
}
