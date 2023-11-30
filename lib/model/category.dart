class Category {
  final int? id;
  final String? name;
  final int? monthId;
  final String? description;
  Category({this.id, this.name,this.monthId, this.description});
  Map<String, dynamic> toMap() {
    return {'id': id! > 0 ? id : 0, 'name': name, 'monthId':monthId ,'description': description};
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
        id: map['id'], name: map['name'],monthId: map['monthId'], description: map['description']);
  }
}