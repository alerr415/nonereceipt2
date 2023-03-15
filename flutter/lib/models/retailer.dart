class Retailer {
  final int id;
  final String name;
  final String vat;
  final String address;

  Retailer({
    required this.id,
    required this.name,
    required this.vat,
    required this.address,
  });

  factory Retailer.fromJson(Map<String, dynamic> json) {
    return Retailer(
      id: json['id'] as int,
      name: json['name'] as String,
      vat: json['vat'] as String,
      address: json['address'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'vat': vat,
      'address': address,
    };
  }
}
