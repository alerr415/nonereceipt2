class Retailer {
  final String name;
  final String vat;
  final String address;

  Retailer({
    required this.name,
    required this.vat,
    required this.address,
  });

  factory Retailer.fromJson(Map<String, dynamic> json) {
    return Retailer(
      name: json['name'] as String,
      vat: json['vat'] as String,
      address: json['address'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'vat': vat,
      'address': address,
    };
  }
}
