class Task {
  final int? id;
  final int? categoryId;
  final String? name;
  final int? price;
  final int? quantity;
  final int? total;
  Task(
      {this.id,
      this.categoryId,
      this.name,
      this.price,
      this.quantity,
      this.total
      });
  Map<String, dynamic> toMap() {
    return {
      'id': id! > 0 ? id : 0,
      'categoryId': categoryId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'total': total,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      categoryId: map['categoryId'],
      name: map['name'],
      price: map['price'],
      quantity: map['quantity'],
      total: map['total'],
     // date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }
}
