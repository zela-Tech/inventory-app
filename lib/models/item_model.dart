class Item {
  final String id;
  final String name;
  final String category;
  final int quantity;
  final double price; 

  Item({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'name':name,
      'category':category ,   
      'quantity':quantity,
      'price':price,    
    };
  }

  factory Item.fromMap(String id, Map<String, dynamic> map) {
    return Item(
      id:id,
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      quantity: (map['quantity'] ?? 0).toInt(),
      price: (map['price'] ?? 0.0).toDouble(),
    );
  }

  Item copyWith({
    String? name,
    String? category,
    int? quantity,
    double?price,
  }) {
    return Item(
      id: id,
      name:name ?? this.name,
      category: category ?? this.category,
      quantity:quantity ?? this.quantity,
      price:price ?? this.price,
    );
  }
}